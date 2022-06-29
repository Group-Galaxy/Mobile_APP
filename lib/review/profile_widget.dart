import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProfileWidegt extends StatefulWidget {
  final String? driverId;
  final ScrollController scrollController;
  const ProfileWidegt({Key? key, this.driverId, required this.scrollController}) : super(key: key);

  @override
  State<ProfileWidegt> createState() => _ProfileWidegtState();
}

class _ProfileWidegtState extends State<ProfileWidegt> {
  @override
  Widget build(BuildContext context) {
    final driverId = widget.driverId ?? "3hQPIZQq1lPVtjWoAW3shKBCTtf1";
    CollectionReference users = FirebaseFirestore.instance
        .collection('vehicle repair service provider');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(driverId).get(),
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          maxRadius: 50,
                          backgroundColor: Colors.red,
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
                              onPressed: () {}, child: const Text("Chat")),
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
