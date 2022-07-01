import 'package:flutter/material.dart';

import 'package:mypart/reviews/profile_widget.dart';

import 'comments_widget.dart';

class ReviewShowScreen extends StatefulWidget {
  final String? getterId;
  final String? getter;
  final String? sender;
  const ReviewShowScreen({Key? key, this.getterId, this.getter, this.sender})
      : super(key: key);

  @override
  State<ReviewShowScreen> createState() => _ReviewShowScreenState();
}

class _ReviewShowScreenState extends State<ReviewShowScreen> {
  @override
  Widget build(BuildContext context) {
    //final driverId = widget.getterId ?? "3hQPIZQq1lPVtjWoAW3shKBCTtf1";
    ScrollController scrollController = ScrollController();

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ProfileWidegt(
            getterId: widget.getterId,
            scrollController: scrollController,
            getter: widget.getter,
            sender: widget.sender,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Comments"),
          ),
          CommentsWidget(
            getterId: widget.getterId,
            scrollController: scrollController,
            getter: widget.getter,
          )
        ],
      )),
    );
  }
}
