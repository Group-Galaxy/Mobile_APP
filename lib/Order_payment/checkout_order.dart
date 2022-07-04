import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypart/Order_payment/checkout_receipt.dart';
import 'package:mypart/buyer/vehicle_parts_home.dart';
import 'package:mypart/gateway.dart';
import 'package:mypart/usermangment/usermodel.dart';
import 'package:getwidget/getwidget.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mypart/controller/payment_controller.dart';

class checkoutorder extends StatefulWidget {
  var date;
  var price;
  var providerName;
  var qty;
  var service_provider_id;
  var contactNO;
 
 
  String? item;

  checkoutorder(
      {Key? mykey,
      this.date,
      this.price,
      this.providerName,
      this.qty,
      required this.item,
      this.contactNO,
     
     
      required this.service_provider_id})
      : super(key: mykey);

  @override
  _checkoutorderState createState() => _checkoutorderState();
}

class _checkoutorderState extends State<checkoutorder> {
  User? currentAutoPartsProvider = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel CurrentServiceprovider = VehicleOwnerModel();
  CollectionReference orders =
      FirebaseFirestore.instance.collection('orderpayments');
  final user = FirebaseAuth.instance.currentUser;

  var _date = DateTime.now().toString();

  TextEditingController _Address = new TextEditingController();

  double subTotal = 0.0;

  double diliveryFee = 0.0;

  double discountValue = 0.0;

  double resultValue = 0.0;

  double balanceValue = 0.0;

  var currentUser = {};
  @override
  void initState() {
    super.initState();

    final data = FirebaseFirestore.instance
        .collection('VehicleOwner')
        .where("uid", isEqualTo: user!.uid)
        .get()
        .then((res) {
      print(res.docs.first.data()['firstName']);
      setState(() {
        currentUser = res.docs.first.data();
      });
    });
    print(data);
  }
  // void getUser()async{

  //}

  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());

    final delivery_fee = 500;
    final total_fee = widget.price * widget.qty +
        ((widget.qty == 1)
            ? delivery_fee
            : (widget.qty == 2)
                ? 750
                : 1000);

    print("uid " + user!.uid);

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 213, 249),
        appBar: AppBar(
          title: Text('Checkout Order'),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: Card(
          child: SingleChildScrollView(
              child: Column(children: [
            GFListTile(
              color: GFColors.WHITE,
              titleText: 'Item : ${widget.item}',
            ),
            GFListTile(
              color: GFColors.WHITE,
              titleText: 'Date : ${widget.date.toString().substring(0, 10)}',
            ),
            GFListTile(
              color: GFColors.WHITE,
              titleText: 'User Name : ${currentUser['firstName']}',
            ),
            GFListTile(
              color: GFColors.WHITE,
              titleText: 'Contact No : ${widget.contactNO}',
            ),
            GFListTile(
              color: GFColors.WHITE,
              titleText: 'Parts Provider Name : ${widget.providerName}',
            ),
            GFListTile(
              color: GFColors.WHITE,
              titleText: 'Unit Price : ${widget.price}',
            ),
            GFListTile(
              color: GFColors.WHITE,
              titleText: 'Quantity : ${widget.qty}',
            ),
            GFListTile(
              color: GFColors.WHITE,
              titleText:
                  'Delivery fee : ${(widget.qty == 1) ? delivery_fee : (widget.qty == 2) ? 750 : 1000}',
            ),
            GFListTile(
              color: GFColors.WHITE,
              titleText: 'Total : ${total_fee}/=',
            ),
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                    //style: TextStyle(color: Colors.black),
                    controller: _Address,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.description,
                          color: Colors.black,
                        ),
                        labelText: 'Address ',
                        labelStyle: TextStyle(color: Colors.black)))),
            ButtonBar(
              children: [
                RaisedButton(
                  child: Text("Confrorm Order"),
                  textColor: Colors.white,
                  color: Colors.purple,
                  onPressed: ()  {
                    showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                        content: const Text(
                            "Your order is placed sucessfully , Please waiting for seller response"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => VehiclePartsHome()));
                            },
                            child: Container(
                              color: Colors.green,
                              padding: const EdgeInsets.all(14),
                              child: const Text("okay"),
                            ),
                          ),
                        ]),
                  );
                    
                  },
                ),
              ],
            ),
          ])),
          elevation: 8,
          shadowColor: Colors.purple,
          margin: EdgeInsets.all(15),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.purple, width: 2)),
        ));
  }
}
