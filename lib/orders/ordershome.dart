import 'package:flutter/material.dart';
import 'package:mypart/dashboard/dashboard.dart';

import 'orderdetails.dart';

class Myorders extends StatefulWidget {
  const Myorders({Key? key}) : super(key: key);

  @override
  State<Myorders> createState() => _MyordersState();
}

class _MyordersState extends State<Myorders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
          leading: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const NavSide(
                            title: 'Dashboard',
                          )));
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Center(
                child: Tab(text: "New\nOrders"),
              ),
              Center(
                child: Tab(text: "To pay"),
              ),
              Center(
                child: Tab(text: "to deliver"),
              ),
              Center(
                child: Tab(text: "finished orders"),
              ),
              Center(
                child: Tab(text: "Cancelled orders"),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Neworders(),
            ToPayOrders(),
            ToDeliver(),
            Finished(),
            Cancelled()
          ],
        ),
      ),
    );
  }
}

