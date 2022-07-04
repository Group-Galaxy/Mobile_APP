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
      backgroundColor: Color.fromARGB(255, 245, 213, 249),
      appBar: AppBar(
        title: Text('To pay'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
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
          //print(snap.data!.docs.first.data());
          //return Text("data fetched!");
          var snap_data = snap.data!.docs;
          return ListView(
            children: snap.data!.docs.map((value) {
              var en_chat = jsonEncode(value.data());
              var chat = jsonDecode(en_chat);
              return Center(
                child: Card(
                  child: SingleChildScrollView(
                      child: Column(children: [
                    GFListTile(
                      color: GFColors.WHITE,
                      title: Text(chat['date']),
                    ),
                    GFListTile(
                      color: GFColors.WHITE,
                      title: Text(chat['vehicleFault']),
                    ),
                    GFListTile(
                      color: GFColors.WHITE,
                      title: Text(chat['balance']),
                    ),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Pay',
                            style: TextStyle(fontSize: 10),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                              fixedSize: const Size(90, 9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ],
                    ),
                  ])),
                  // title: Text(chat['vehicleFault']),
                  // subTitle: Text("To pay: ${chat['balance']}"),
                  elevation: 8,
                  shadowColor: Colors.purple,
                  margin: EdgeInsets.all(15),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.purple, width: 2)),
                ),
              );
            }).toList(),
          );
        },
      )),
    );
  }
}
