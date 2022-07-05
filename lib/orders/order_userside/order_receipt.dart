import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypart/Order_payment/checkout_receipt.dart';
import 'package:mypart/buyer/vehicle_parts_home.dart';
import 'package:mypart/gateway.dart';
import 'package:mypart/reviews/review_give_screen.dart';
import 'package:mypart/usermangment/usermodel.dart';
import 'package:getwidget/getwidget.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mypart/controller/payment_controller.dart';
import 'package:mypart/usermangment/welcomeScreen.dart';

class OrderReceipt extends StatefulWidget {
  DocumentSnapshot docid;
  var date;
  var price;
  var providerName;
  var qty;
  var service_provider_id;

  String? item;

  OrderReceipt(
      {Key? mykey,
      this.date,
      this.price,
      this.providerName,
      this.qty,
      required this.item,
      required this.service_provider_id,
      required this.docid})
      : super(key: mykey);

  @override
  _OrderReceiptState createState() => _OrderReceiptState();
}

class _OrderReceiptState extends State<OrderReceipt> {
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
    print(data);
  }
  // void getUser()async{

  //}

  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());

    final delivery_fee = 500;
    final total_fee = double.parse(widget.price) +
        ((widget.qty == 1)
            ? delivery_fee
            : (widget.qty == 2)
                ? 750
                : 1000);

    print("uid " + user!.uid);

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 213, 249),
        appBar: AppBar(
          title: Text('Order Receipt'),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: Card(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GFListTile(
                  color: GFColors.WHITE,
                  titleText:
                      'Item : ${(widget.item == null) ? "Honda GP" : widget.item}',
                ),
                GFListTile(
                  color: GFColors.WHITE,
                  titleText:
                      'Date : ${(widget.date == null) ? DateTime.now().toString().substring(0, 10) : widget.date.toString().substring(0, 10)}',
                ),
                GFListTile(
                  color: GFColors.WHITE,
                  titleText: 'User Name : ${currentUser['firstName']}',
                ),
                GFListTile(
                  color: GFColors.WHITE,
                  titleText: 'Contact No : ${currentUser['contactNo']}',
                ),
                GFListTile(
                  color: GFColors.WHITE,
                  titleText:
                      'Parts Provider Name : ${(widget.providerName == null) ? "Fake User" : widget.providerName}',
                ),
                GFListTile(
                  color: GFColors.WHITE,
                  titleText:
                      'Unit Price : ${(widget.price == null) ? "Rs.1000/=" : (double.parse(widget.price) / double.parse(widget.qty))}',
                ),
                GFListTile(
                  color: GFColors.WHITE,
                  titleText:
                      'Quantity : ${(widget.qty == null) ? "1" : widget.qty}',
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
                ButtonBar(children: [
                  RaisedButton(
                      child: Text("Pay"),
                      textColor: Colors.white,
                      color: Colors.purple,
                      onPressed: () async {
                        await widget.docid.reference
                            .update({'Oreder Status': 'paid'});
                        int fee = total_fee.toInt();
                        await controller.makePayment(
                            amount: '${fee}', currency: 'LKR');
                        await controller.addpaymentDataToDb(
                          userName: currentUser['firstName'],
                          serviceProviderID: widget.service_provider_id,
                          date: widget.date.toString(),
                          balance: '${total_fee}'.toString(),
                          subTotal: widget.price.toString(),
                          quantity: widget.qty.toString(),
                          item: widget.item.toString(),
                          delivery_fee: ((widget.qty == 1)
                                  ? delivery_fee
                                  : (widget.qty == 2)
                                      ? 750
                                      : 1000)
                              .toString(),
                          contactNo: currentUser['contactNo'].toString(),
                          ordersNo: widget.docid,
                          address: _Address.text,
                        );
                        await Future.delayed(const Duration(seconds: 15));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReviewGiveScreen()));
                      })
                ])
              ],
            ),
          ),
          elevation: 8,
          shadowColor: Colors.purple,
          margin: EdgeInsets.all(15),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.purple, width: 2)),
        ));
  }
}
