//import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mypart/buyer/productProvider.dart';
import 'package:mypart/buyer/products.dart';
import 'package:mypart/buyer/searchhome.dart';
import 'package:mypart/designs/bottombar.dart';
import 'package:mypart/firebaseservice.dart';
import 'package:mypart/orders/order_userside/userorderdetails.dart';
import 'package:mypart/orders/order_userside/userordermain.dart';
import 'package:mypart/usermangment/usermodel.dart';

import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class productDetails extends StatefulWidget {
  @override
  State<productDetails> createState() => _productDetailsState();
}

class _productDetailsState extends State<productDetails> {
  FirebaseService _service = FirebaseService();
  User? vehicleowner = FirebaseAuth.instance.currentUser;
      VehicleOwnerModel loggedInUser = VehicleOwnerModel();
       CollectionReference orders = FirebaseFirestore.instance.collection('Order Details');
       CollectionReference user = FirebaseFirestore.instance.collection('users');
       CollectionReference notifications = FirebaseFirestore.instance.collection('notifications');


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(vehicleowner!.uid)
        .get()
        .then((value) {
      this.loggedInUser = VehicleOwnerModel.fromMap(value.data());
      setState(() {});
    });
  }

  int OrderQuantity = 0;
  var today = new DateTime.now();
  String OrderStatus = "Pending";
  @override
  Widget build(BuildContext context) {
    final _PriceFormat = NumberFormat('##,##,##0');
    var _productProvider = Provider.of<ProductProvider>(context);
    var data = _productProvider.ProductData;
    var _price = int.parse(data['Item Price']);

    String _FormatedPrice = '\Rs. ${_PriceFormat.format(_price)}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Home()));
          },
        ),
        actions: [
          LikeButton(
            likeBuilder: (bool isLiked) {
              return Icon(
                Icons.favorite,
                color: isLiked ? Colors.purple : Colors.grey,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              color: Color.fromARGB(255, 222, 219, 219),
              child: PhotoView(
                imageProvider: NetworkImage(data['Imageurl']),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(data['Item Name'],
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        SizedBox(width: 70),
                        Column(
                          children: [
                            QuantityInput(
                              label: 'Qty',
                              value: OrderQuantity,
                              onChanged: (value) => setState(() =>
                                  OrderQuantity =
                                      int.parse(value.replaceAll(',', ''))),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(_FormatedPrice,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Warrenty: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                          SizedBox(
                            width: 20,
                          ),
                          Text(data['Warenty Period'],
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Condition: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                          SizedBox(
                            width: 20,
                          ),
                          Text(data['Condition'],
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Features: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                          SizedBox(
                            width: 20,
                          ),
                          Text(data['Item Features'],
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Seller Details: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                          SizedBox(
                            width: 20,
                          ),
                          Text('J K Motors', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text('Contact No: ', style: TextStyle(fontSize: 12)),
                          SizedBox(
                            width: 20,
                          ),
                          Text('0715978410', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text('Location', style: TextStyle(fontSize: 12)),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Wester,Gampha,Negambo',
                              style: TextStyle(fontSize: 12)),
                          Icon(
                            Icons.location_on,
                            size: 18,
                            color: Colors.deepPurple,
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Ratings & Comments: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      /*floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),*/
      bottomSheet: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          children: [
            Expanded(
                child: NeumorphicButton(
              style: NeumorphicStyle(color: Colors.purple),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.chat_bubble,
                      size: 16, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Chat',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: NeumorphicButton(
              onPressed: () {
                          
                          today = new DateTime(today.year, today.month, today.day,today.hour,today.minute); 
                          String message="You have new order";
                             
               orders.add({
                'Item Name': data['Item Name'],
                'Item Price': data['Item Price'],
                'Item Qty':OrderQuantity.toString(),
                
                'Imageurl': data['Imageurl'],
                'Order Date Time':today,
                'vehicle Owner Id':loggedInUser.uid,
               'Vehicle Owner Name': loggedInUser.firstName,
                'Service Provider Id':data['Service Provider Id'],
                'Service Provider Name':data['Service Provider Name'],
                'Oreder Status':OrderStatus,
                }
                );

                notifications.add(
                  {
                    'ItemName':data['Item Name'],
                    'Sender':loggedInUser.uid,
                    'receiver':data['Service Provider Id'],
                    'message':message,
                    'DateTime':today
                  }
                );
                user.doc(loggedInUser.uid).collection('UserOrders').add({
                'Item Name': data['Item Name'],
                'Item Price': data['Item Price'],
                'Item Qty':OrderQuantity.toString(),
                
                'Imageurl': data['Imageurl'],
                'Order Date Time':today,
                
                'Service Provider Id':data['Service Provider Id'],
                
                'Oreder Status':OrderStatus,
                })

                .whenComplete(() {
                
                    showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                
                  content: const Text("Your order is placed sucessfully , Please waiting for seller response"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                          Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Home()));
                      },
                      child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(14),
                        child: const Text("okay"),
                      ),
                    ),
                  ]
                ),
                    );
                });
              },
              style: NeumorphicStyle(color: Colors.purple),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.square_list,
                      size: 16, color: Colors.white),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Order',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )),
          ],
        ),
      )),
    );
  }
}
