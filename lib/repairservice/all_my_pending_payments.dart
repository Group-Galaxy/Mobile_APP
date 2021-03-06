import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:get/utils.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:mypart/controller/payment_controller_repaire.dart';
import 'package:mypart/gateway.dart';
import 'package:mypart/reviews/review_give_screen.dart';

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
    final PaymentController2 controller = Get.put(PaymentController2());
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
                      title: Text('Date : ${chat['date'].substring(0, 10)}'),
                    ),
                    GFListTile(
                      color: GFColors.WHITE,
                      title: Text('Vehicle Fault : ${chat['vehicleFault']}'),
                    ),
                    GFListTile(
                      color: GFColors.WHITE,
                      title: Text('Amount to Pay : ${chat['balance']}'),
                    ),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            child: Text(
                              'Pay',
                              style: TextStyle(fontSize: 10),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple,
                                fixedSize: const Size(90, 9),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            onPressed: () async {
                              int fee = double.parse(chat['balance']).toInt();
                              await controller.makePayment(
                                  amount: '${fee}', currency: 'LKR');
                              await controller.addpaymentDataToDb(
                                is_paid: true,
                                balance: '${chat['balance']}',
                                date: '${chat['date']}',
                                discount: '${chat['discount']}',
                                inspectionValue: '${chat['inspectionValue']}',
                                serviceProviderName:
                                    '${chat['serviceProviderName']}',
                                userName: '${chat['userName']}',
                                vehicleFault: '${chat['vehicleFault']}',
                                DocID: '${chat['DocID']}',
                              );
                              await Future.delayed(const Duration(seconds: 10));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ReviewGiveScreen()));
                            }
                            /* onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Gateway()));
                          }, */

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
