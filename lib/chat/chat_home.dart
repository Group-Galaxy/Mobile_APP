import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'chat_page.dart';

class ChatHome extends StatefulWidget {
  final String? talkId;
  final String? sender;
  final String? imgUrl;
  const ChatHome({Key? key, this.talkId, this.sender, this.imgUrl})
      : super(key: key);
  @override
  _ChatHomeState createState() =>
      _ChatHomeState(talkId: talkId, category: sender);
}

class _ChatHomeState extends State<ChatHome> {
  String? talkId;
  final String? category;
  _ChatHomeState({this.category, this.talkId});

  @override
  Widget build(BuildContext context) {
    final curr = FirebaseAuth.instance.currentUser;

    final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
        .collection('${widget.sender}/${curr?.uid}/MessagesList')
        .orderBy('lastMsgTime')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: StreamBuilder(
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
              Timestamp t =
                  qs['lastMsgTime'] ?? Timestamp.fromDate(DateTime.now());
              DateTime d = t.toDate();
              print(d.toString());

              return !qs['isRespone']
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chatpage(
                                        getter: qs['getter'] ,
                                        sender: qs['sender'],
                                        getterName: qs['name'],
                                        getterId: qs['getterId'],
                                      )));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.purple,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.grey,
                                    child: CachedNetworkImage(
                                      height: 100,
                                      width: 100,
                                      imageUrl: qs['imgUrl'],
                                      placeholder: (context, url) =>
                                          const SizedBox(
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                              Icons.account_circle_outlined),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            qs['name'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${d.hour}:${d.minute}",
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
