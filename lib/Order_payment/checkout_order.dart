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
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  User? currentAutoPartsProvider = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel CurrentServiceprovider = VehicleOwnerModel();
  CollectionReference orders =
      FirebaseFirestore.instance.collection('orderpayments');
  final user = FirebaseAuth.instance.currentUser;

  var _date = DateTime.now().toString();

  final addressEditingController = TextEditingController();
  double subTotal = 0.0;

  double diliveryFee = 0.0;

  double discountValue = 0.0;

  double resultValue = 0.0;

  double balanceValue = 0.0;

  var currentUser = {};
  var pp_provider = {};
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
    final pp_data = FirebaseFirestore.instance
        .collection('vehicl parts providers')
        .where("uid", isEqualTo: widget.service_provider_id)
        .get()
        .then((res) {
      //print(res.docs.first.data()['firstName']);
      setState(() {
        pp_provider = res.docs.first.data();
      });
    });
    print(pp_provider);
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
          // ignore: sort_child_properties_last
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

            /* final addressField = TextFormField(
        autofocus: false,
        controller: addressEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Address cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          secondNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));*/
            ButtonBar(
              children: [
                RaisedButton(
                  child: Text("Confrorm Order"),
                  textColor: Colors.white,
                  color: Colors.purple,
                  onPressed: () {
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
            // addressField,
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
