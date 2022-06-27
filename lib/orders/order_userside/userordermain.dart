


  import 'package:flutter/material.dart';
import 'package:mypart/buyer/searchhome.dart';
import 'package:mypart/orders/order_userside/userorderdetails.dart';






class Myorders extends StatefulWidget {
  const Myorders({Key? key}) : super(key: key);

  @override
  State<Myorders> createState() => _MyordersState();
}

class _MyordersState extends State<Myorders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          
          title: const Text(" My Orders"),
          leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Home()));
          },
        ),
          bottom: const TabBar(
            tabs: [
              Center(
                child: Tab(text: "New\nOrders"),
              ),
              Center(
                child: Tab(text: "To deliveres"),
              ),
              Center(
                child: Tab(text: "Finished\nOrders"),
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
            Todelivered(),
            Finished(),
            Cancelled()
          ],
        ),
      ),
    );
  }
}

