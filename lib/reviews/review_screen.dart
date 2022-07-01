import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../usermangment/usermodel.dart';

class ReviewGiveScreen extends StatefulWidget {
  final String? driverId;
  final String? category;
  const ReviewGiveScreen({
    Key? key,
    this.driverId, this.category,
  }) : super(key: key);

  @override
  State<ReviewGiveScreen> createState() => _ReviewGiveScreenState();
}

class _ReviewGiveScreenState extends State<ReviewGiveScreen> {
  double rate = 0.0;
  final TextEditingController _textEditingController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser;
  addReview() {
    final driverId = widget.driverId ?? "lnL9eiQ9dsRPlykqT4SDL03c63z2";
    CollectionReference users = FirebaseFirestore.instance
        .collection('${widget.category}/$driverId/review');
       
    users
        .add({
          'userId': userId?.uid,
          'rate': rate,
          'comment': _textEditingController.text.trim(),
          'time': FieldValue.serverTimestamp(),
          'userName': userId?.displayName ?? "No name",
          'photourl': userId?.photoURL
        })
        .then((value) => print("User Review"))
        .catchError((error) => print("Failed to add review: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  rate = rating;
                  print(rating);
                },
              ),
              TextFormField(
                controller: _textEditingController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              ElevatedButton(onPressed: addReview, child: const Text("Submit"))
            ],
          ),
        ),
      ),
    ));
  }
}
