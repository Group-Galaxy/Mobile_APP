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

class ViewMoreOrders extends StatefulWidget {
  var total_fee;
  var date;
  var price;
  var providerName;
  var qty;
  var service_provider_id;
  var contactNO;
  var deliveryfee;
  var Imageurl;
  var OrderStatus;
  String? item;

  ViewMoreOrders(
      {Key? mykey,
      this.date,
      this.price,
      this.providerName,
      this.qty,
      required this.item,
      this.contactNO,
      this.total_fee,
      this.deliveryfee,
      this.Imageurl,
      this.OrderStatus,
      required this.service_provider_id})
      : super(key: mykey);

  @override
  _ViewMoreOrdersState createState() => _ViewMoreOrdersState();
}

class _ViewMoreOrdersState extends State<ViewMoreOrders> {
  User? currentAutoPartsProvider = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel CurrentServiceprovider = VehicleOwnerModel();
 
  final user = FirebaseAuth.instance.currentUser;

  var _date = DateTime.now().toString();

  
  @override
 
  

  Widget build(BuildContext context) {
    

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('View More'),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body:SafeArea(


              child: Column(children: [


                Row(
                    
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, top: 5),
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: Image.network(
                                '${widget.Imageurl}'

                                 ),
                            ),
                          ),
                        ),
                      ],
                    ),
                      SizedBox(
                        width: 50,
                      ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                 '${widget.item}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                          children: [
                            Text(
                               'Quantity: ${widget.qty}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                         Row(
                          children: [
                            Text(
                              'Unit Price :  Rs.${widget.price}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        )
                          ],
                        ),
                        
                       
                  ],
                ),
                  const Divider(color: Colors.grey),
           
            // GFListTile(
            //   color: GFColors.WHITE,
            //   titleText: 'Date : ${widget.date.toString().substring(0, 10)}',
            // ),
                   Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Text('Order Status:  ${widget.OrderStatus}',
                              style: TextStyle(
                                  
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                          
                        ],
                      ),
                    ),
          
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Text('Delivery Fee:  Rs.${widget.deliveryfee}',
                              style: TextStyle(
                                  
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                          
                        ],
                      ),
                    ),

                Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Text('Total Fee:  Rs.${widget.total_fee} ',
                              style: TextStyle(
                                  
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                          
                        ],
                      ),
                    ),
                     Divider(color: Colors.grey,),

                        Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Seller Details: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                            ],
                          ),
                           SizedBox(
                            height: 20,
                          ),
                           
                          Row(
                           children: [
                              Text( '${widget.providerName}',
                              style: TextStyle(
                                 
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                           ], 
                          )
                         
                         
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Text('    Contact No:  ${widget.contactNO}',
                              style: TextStyle(
                                 
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                         
                        ],
                      ),
                    ),
               Divider(color: Colors.grey),
            
          ])),
         
        );
  }
}
