import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypart/Order_payment/checkout_receipt.dart';
import 'package:mypart/gateway.dart';
import 'package:mypart/usermangment/usermodel.dart';
import 'package:getwidget/getwidget.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mypart/controller/payment_controller.dart';

class checkoutorder extends StatefulWidget {
  //String Date,
  // ServiceProviderID,
  // UserName,
  // Item,
  //  Quantity,
  // ContactNumber,
  //  SubTotal;
  // DiliveryFee,
  // Discount,
  // Balance;

  /*checkoutorder(
      {Key? mykey,
      required this.Date,
      required this.ServiceProviderID,
      required this.Item,
      required this.Quantity,
      required this.SubTotal})
      : super(key: mykey);*/

  var date;
  var price;
  var providerName;
  var qty;
  var service_provider_id;
  String? item;

  checkoutorder(
      {Key? mykey,
      this.date,
      this.price,
      this.providerName,
      this.qty,
      required this.item,
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
  TextEditingController _ServiceProviderID = new TextEditingController();
  TextEditingController _UserName = new TextEditingController();
  TextEditingController _Item = new TextEditingController();
  TextEditingController _Quantity = new TextEditingController();
  TextEditingController _ContactNumber = new TextEditingController();
  TextEditingController _Address = new TextEditingController();
  TextEditingController _SubTotal = new TextEditingController();
  TextEditingController _DiliveryFee = new TextEditingController();
  TextEditingController _Discount = new TextEditingController();
  TextEditingController _balance = new TextEditingController();

  double subTotal = 0.0;

  double diliveryFee = 0.0;

  double discountValue = 0.0;

  double resultValue = 0.0;

  double balanceValue = 0.0;

  var currentUser = {};
  @override
  void initState() {
    super.initState();
    // FirebaseFirestore.instance
    //     .collection("Order Details")
    //     .doc(currentAutoPartsProvider!.displayName)
    //     .get()
    //     .then((value) {
    //   this.CurrentServiceprovider = VehicleOwnerModel.fromMap(value.data());

    //   setState(() {});
    // });
    final data = FirebaseFirestore.instance
        .collection('users')
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
    print("uid " + user!.uid);

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 213, 249),
        appBar: AppBar(
          title: Text('Checkout Order'),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          /*DateTimePicker(
            initialValue: DateTime.now().toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            icon: Icon(Icons.calendar_today),
            dateLabelText: ' Date',
            onChanged: (val) {
              print(_date);
              setState(() {
                _date = val.toString().substring(0, 10);
              });
              print(_date);
            },
            validator: (val) {
              return null;
            },
            onSaved: (val) {},
          ),*/
          // FutureBuilder<QuerySnapshot>(
          //   future: orders
          //       .where(
          //         'Service Provider Name',
          //         isEqualTo: CurrentServiceprovider.firstName,
          //       )
          //       .where('Oreder Status', isEqualTo: 'Pending')
          //       .get(),
          //   builder:
          //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (snapshot.hasError) {
          //       return Text("something is wrong");
          //     }
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }

          /* TextField(
              controller: _ServiceProviderID,
              decoration: InputDecoration(
                  icon: Icon(Icons.people),
                  labelText: ' Service Provider Name')),*/
          //Text("${widget.date}"),
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
            titleText: 'Contact No : ${currentUser['contactNo']}',
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
            titleText:
                'Total : ${widget.price * widget.qty + ((widget.qty == 1) ? delivery_fee : (widget.qty == 2) ? 750 : 1000)}/=',
          ),

          // Text("${widget.price}"),

          // Text("${widget.providerName}"),

          // Text("${widget.qty}"),

          Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                  controller: _Address,
                  decoration: InputDecoration(
                      icon: Icon(Icons.description), labelText: 'Address '))),

          /* Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                  controller: _Quantity,
                  decoration: InputDecoration(
                      icon: Icon(Icons.description), labelText: 'Quantity '))),
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                  controller: _ContactNumber,
                  decoration: InputDecoration(
                      icon: Icon(Icons.description),
                      labelText: 'Contact Number'))),
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                  controller: _SubTotal,
                  decoration: InputDecoration(
                      icon: Icon(Icons.description), labelText: 'Sub Total'))),
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                  controller: _DiliveryFee,
                  decoration: InputDecoration(
                      icon: Icon(Icons.description),
                      labelText: 'Dilivery Fee'))),
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                  controller: _Discount,
                  decoration: InputDecoration(
                      icon: Icon(Icons.description), labelText: 'Discount'))),
          SizedBox(
            height: 20,
          ),
          Text("Balance = $balanceValue",
              style: TextStyle(
                fontSize: 20,
              )),
          Divider(color: Colors.black),
          SizedBox(
            height: 20,
          ),*/
          ButtonBar(
            children: [
              RaisedButton(
                child: Text("Pay Now"),
                textColor: Colors.white,
                color: Colors.purple,
                onPressed: () async {
                  await controller.makePayment(
                      amount: '${widget.price}', currency: 'LKR');
                  await controller.addpaymentDataToDb(
                      userName: currentUser['firstName'],
                      serviceProviderID: widget.service_provider_id,
                      date: widget.date.toString(),
                      balance: (widget.price * widget.qty +
                              ((widget.qty == 1)
                                  ? delivery_fee
                                  : (widget.qty == 2)
                                      ? 750
                                      : 1000))
                          .toString(),
                      subTotal: widget.price.toString(),
                      quantity: widget.qty.toString(),
                      item: widget.item!,
                      delivery_fee: ((widget.qty == 1)
                              ? delivery_fee
                              : (widget.qty == 2)
                                  ? 750
                                  : 1000)
                          .toString(),
                      contactNo: currentUser['contactNo'].toString());

                  // subTotal = double.parse(_SubTotal.text);
                  // diliveryFee = double.parse(_DiliveryFee.text);
                  // discountValue = double.parse(_Discount.text);

                  // resultValue = ((subTotal + diliveryFee) - discountValue);

                  // setState(() {
                  //   balanceValue = resultValue;
                  // });

                  // final ServiceProviderID = _ServiceProviderID.text;
                  // final UserName = _UserName.text;
                  // final Item = _Item.text;
                  // final Quantity = _Quantity.text;
                  // final ContactNumber = _ContactNumber.text;
                  // final SubTotal = _SubTotal.text;
                  // final DiliveryFee = _DiliveryFee.text;
                  // final Discount = _Discount.text;
                  // final Balance = resultValue.toString();
                  // final Date = _date;

                  // createUser(
                  //   ServiceProviderID: ServiceProviderID,
                  //   UserName: UserName,
                  //   Item: Item,
                  //   Quantity: Quantity,
                  //   ContactNumber: ContactNumber,
                  //   SubTotal: SubTotal,
                  //   DiliveryFee: DiliveryFee,
                  //   Discount: Discount,
                  //   Balance: Balance,
                  //   Date: Date,
                  // );

                  // print("the selected date is ${_date}");
                  // Navigator.of(context)
                  //  .push(MaterialPageRoute(builder: (context) => Gateway(

                  //   )));
                  //           ServiceProviderID: _ServiceProviderID.text,
                  //           UserName: _UserName.text,
                  //           Item: _Item.text,
                  //           Quantity: _Quantity.text,
                  //           ContactNumber: _ContactNumber.text,
                  //           SubTotal: _SubTotal.text,
                  //           DiliveryFee: _DiliveryFee.text,
                  //           Discount: _Discount.text,
                  //           Balance: resultValue.toString(),
                  //           Date: _date,
                  //         )));
                },
              ),
            ],
          ),
        ])));

//   Future createUser(
//       {required String ServiceProviderID,
//       UserName,
//       Item,
//       Quantity,
//       ContactNumber,
//       SubTotal,
//       DiliveryFee,
//       Discount,
//       Balance,
//       Date}) async {
//     final docUser =
//         FirebaseFirestore.instance.collection('orderpayments').doc();
//     final json = {
//       'serviceProviderID': ServiceProviderID,
//       'userName': UserName,
//       'Item': Item,
//       'Quantity': Quantity,
//       'ContactNumber': ContactNumber,
//       'SubTotal': SubTotal,
//       'DiliveryFee': DiliveryFee,
//       'discount': Discount,
//       'balance': Balance,
//       'date': Date,
//     };

//     /// Create doc & write data to Firebase
//     await docUser.set(json);
//   }}
  }
}
