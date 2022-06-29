import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class CommentsWidget extends StatefulWidget {
  final String? driverId;
final ScrollController scrollController;
  const CommentsWidget({Key? key, this.driverId, required this.scrollController}) : super(key: key);

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  @override
  Widget build(BuildContext context) {
    final driverId = widget.driverId ?? "3hQPIZQq1lPVtjWoAW3shKBCTtf1";

    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
        .collection('vehicle repair service provider/$driverId/review')
        .orderBy('time', descending: true)
        .snapshots();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        height: MediaQuery.of(context).size.height * 0.6,
        child: StreamBuilder<QuerySnapshot>(
          stream: usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              controller: widget.scrollController,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Row(
                  children: [
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            maxRadius: 35,
                            backgroundColor: Colors.red,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data['comment']),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(data['userName'] ?? ""),
                        ),
                        RatingBar.builder(
                          itemSize: 20,
                          initialRating: data['rate'],
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) {
                            return const Icon(
                              Icons.star,
                              color: Colors.amber,
                            );
                          },
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        )
                      ],
                    )
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

