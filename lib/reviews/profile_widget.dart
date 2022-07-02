import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mypart/chat/chat_page.dart';

class ProfileWidegt extends StatefulWidget {
  final String? getterId;
  final String? getter;
  final String? sender;
  final ScrollController scrollController;
  const ProfileWidegt(
      {Key? key,
      this.getterId,
      required this.scrollController,
      this.getter,
      this.sender})
      : super(key: key);

  @override
  State<ProfileWidegt> createState() => _ProfileWidegtState();
}

class _ProfileWidegtState extends State<ProfileWidegt> {
  @override
  Widget build(BuildContext context) {
    // final driverId = widget.getterId ?? "3hQPIZQq1lPVtjWoAW3shKBCTtf1";
    final fs = FirebaseFirestore.instance;
    final curr = FirebaseAuth.instance.currentUser;
    CollectionReference users =
        FirebaseFirestore.instance.collection('${widget.getter}');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.getterId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Center(child: Text("Document does not exist"));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Row(
                    children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.grey,
                            child: CachedNetworkImage(
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                              imageUrl: data['imgUrl'],
                              placeholder: (context, url) => const CircleAvatar(
                                radius: 30.0,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.account_circle_outlined),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Full Name: ${data['firstName']} "),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Location: ${data['location']} "),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Number: ${data['contactNo']} "),
                            ),
                            RatingBar.builder(
                              initialRating: data['rate'] ?? 5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              ignoreGestures: true,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              itemBuilder: (context, _) {
                                return const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                );
                              },
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 120),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {}, child: const Text("Book")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                fs
                                    .collection(
                                        '${widget.sender}/${curr?.uid}/MessagesList')
                                    .doc(data['uid'])
                                    .set({
                                  "name": data['firstName'] ?? "No name",
                                  'lastMsgTime': FieldValue.serverTimestamp(),
                                  'isRespone': true,
                                  "getterId": widget.getterId,
                                  'imgUrl': data['imgUrl'] ?? "",
                                  "sender": widget.sender,
                                  "getter": widget.getter
                                }, SetOptions(merge: true));
                                 
                                fs
                                    .collection(
                                        '${widget.getter}/${data['uid']}/MessagesList')
                                    .doc(curr?.uid)
                                    .set({
                                  "name": curr?.displayName ?? "No name",
                                  'lastMsgTime': FieldValue.serverTimestamp(),
                                  'isRespone': true,
                                  "getterId": curr?.uid,
                                  'imgUrl': curr?.photoURL ?? "",
                                  "getter": widget.sender,
                                  "sender": widget.getter
                                }, SetOptions(merge: true));

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Chatpage(
                                              getter: widget.getter ??"",
                                              sender: widget.sender ?? "",
                                              getterId: data['uid'],
                                              getterName: data['firstName'],
                                            )));
                              },
                              child: const Text("Chat")),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
