//import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mypart/buyer/productProvider.dart';
import 'package:mypart/buyer/products.dart';
import 'package:mypart/designs/bottombar.dart';
import 'package:mypart/firebaseservice.dart';
import 'package:mypart/orders/order_userside/userorderdetails.dart';
import 'package:mypart/orders/order_userside/userordermain.dart';
import 'package:mypart/seller/ItemProvider.dart';
import 'package:mypart/seller/Items.dart';
import 'package:mypart/usermangment/usermodel.dart';

import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class ItemsDetails extends StatefulWidget {
  @override
  State<ItemsDetails> createState() => _ItemsDetailsState();
}

class _ItemsDetailsState extends State<ItemsDetails> {

  
     

  @override
  Widget build(BuildContext context) {
    final _PriceFormat = NumberFormat('##,##,##0');
    var _productProvider = Provider.of<ItemProvider>(context);
    var data = _productProvider.ItemtData;
    var _price = int.parse(data['Item Price']);

    String _FormatedPrice = '\Rs. ${_PriceFormat.format(_price)}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Items()));
          },
        ),
       
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
                        SizedBox(width: 30),
                        
                      ],
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
     
    );
  }
}
