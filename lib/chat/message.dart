import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Messages extends StatefulWidget {
  String getterId;
  final String sender;
  final String getter;
  Messages(
      {Key? key,
      required this.getterId,
      required this.sender,
      required this.getter})
      : super(key: key);
  @override
  _MessagesState createState() =>
      _MessagesState(talkId: getterId, category: sender);
}

class _MessagesState extends State<Messages> {
  String talkId;
  final String category;
  _MessagesState({required this.category, required this.talkId});

  @override
  Widget build(BuildContext context) {
    final curr = FirebaseAuth.instance.currentUser;

    final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
        .collection(
            '${widget.sender}/${curr?.uid}/MessagesList/${widget.getterId}/Messages')
        .orderBy('time')
        .snapshots();
    return StreamBuilder(
      stream: messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("something is wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot qs = snapshot.data!.docs[index];
            Timestamp t = qs['time'] ?? Timestamp.fromDate(DateTime.now());
            DateTime d = t.toDate();
            print(d.toString());

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: qs['isMe']
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: qs['isImage']
                        ? CachedNetworkImage(
                            height: 250,
                            width: 250,
                            imageUrl: qs['imgUrl'],
                            placeholder: (context, url) => const SizedBox(
                              child: Center(child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : ListTile(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.purple,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(
                              qs['name'],
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    qs['message'],
                                    softWrap: true,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "${d.hour}:${d.minute}",
                                )
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
