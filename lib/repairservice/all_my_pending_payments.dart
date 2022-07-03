import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class MyAllPendingPayments extends StatefulWidget {
  MyAllPendingPayments({Key? key}) : super(key: key);

  @override
  State<MyAllPendingPayments> createState() => _MyAllPendingPaymentsState();
}

class _MyAllPendingPaymentsState extends State<MyAllPendingPayments> {
  final user = FirebaseAuth.instance.currentUser;
  var currentUser = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('VehicleOwner')
        .where("uid", isEqualTo: user!.uid)
        .get()
        .then((res) {
      print(res.docs.first.data()['firstName']);
      setState(() {
        currentUser = res.docs.first.data();
      });
    });
    //FirebaseFirestore.instance.collection('payments').doc()
  }

  @override
  Widget build(BuildContext context) {
    print(currentUser);
    final Stream<QuerySnapshot> _paymetStream = FirebaseFirestore.instance
        .collection('payments')
        .where('userName', isEqualTo: currentUser['firstName'])
        .where("is_paid", isEqualTo: false)
        .snapshots();
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
        stream: _paymetStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
          if (snap.hasError) {
            print("has error");
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snap.connectionState == ConnectionState.waiting) {
            print("waiting....");
            return CircularProgressIndicator.adaptive();
          }
          print(snap.data!.docs.first.data());
          //return Text("data fetched!");
          var snap_data = snap.data!.docs;
          return ListView(
            children: snap.data!.docs.map((value) {
              var en_chat = jsonEncode(value.data());
              var chat = jsonDecode(en_chat);
              return GFListTile(
                color: GFColors.LIGHT,
                title: Text(chat['vehicleFault']),
                subTitle: Text("To pay: ${chat['balance']}"),
              );
            }).toList(),
          );
        },
      )),
    );
  }
}
