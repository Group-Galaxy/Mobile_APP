import 'package:flutter/material.dart';
import 'package:mypart/review/profile_widget.dart';



import 'comments_widget.dart';

class ReviewShowScreen extends StatefulWidget {
  final String? driverId;
  const ReviewShowScreen({Key? key, this.driverId}) : super(key: key);

  @override
  State<ReviewShowScreen> createState() => _ReviewShowScreenState();
}

class _ReviewShowScreenState extends State<ReviewShowScreen> {
  @override
  Widget build(BuildContext context) {
    final driverId = widget.driverId ?? "3hQPIZQq1lPVtjWoAW3shKBCTtf1";
    ScrollController scrollController = ScrollController();

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ProfileWidegt(
            driverId: driverId,
            scrollController: scrollController,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Comments"),
          ),
          CommentsWidget(
            driverId: driverId,
            scrollController: scrollController,
          )
        ],
      )),
    );
  }
}
