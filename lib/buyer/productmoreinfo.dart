//import 'dart:async';

import 'dart:async';
import 'package:uuid/uuid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mypart/Order_payment/checkout_order.dart';
import 'package:mypart/buyer/productProvider.dart';
import 'package:mypart/buyer/products.dart';
import 'package:mypart/buyer/vehicle_parts_home.dart';
import 'package:mypart/designs/bottombar.dart';
import 'package:mypart/firebaseservice.dart';
import 'package:mypart/orders/order_userside/userorderdetails.dart';
import 'package:mypart/orders/order_userside/userordermain.dart';
import 'package:mypart/usermangment/usermodel.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsprousermodel.dart';

import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../chat/chat_page.dart';

class productDetails extends StatefulWidget {
 /* DocumentSnapshot docid;
  var StockQty;*/

  //productDetails({this.StockQty,required this.docid});

 
  @override
  State<productDetails> createState() => _productDetailsState();
}

class _productDetailsState extends State<productDetails> {
  final FirebaseService _service = FirebaseService();
  
  CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');
  CollectionReference user =
      FirebaseFirestore.instance.collection('VehicleOwner');
       CollectionReference Notifications =
      FirebaseFirestore.instance.collection('Notifications');

 

  @override
   String? docid;
  int OrderQuantity = 0;
  var today = DateTime.now();
  String OrderStatus = "Pending";
  @override
  Widget build(BuildContext context) {
    final _PriceFormat = NumberFormat('##,##,##0');
    var _productProvider = Provider.of<ProductProvider>(context);
    var data = _productProvider.ProductData;
    var _price = int.parse(data['Item Price']);
    var stockQty=int.parse(data['StockQty']);
    var RemainnigQty=stockQty-1;
    print(data);
    String _FormatedPrice = '\Rs. ${_PriceFormat.format(_price)}';

    //String FormatedPrice = 'Rs. ${PriceFormat.format(price)}';

    final fs = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => VehiclePartsHome()));
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
              color: const Color.fromARGB(255, 222, 219, 219),
              child: PhotoView(
                imageProvider: NetworkImage(data['Imageurl']),
              ),
            ),
            SizedBox(
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
                            Container(
                              width: 180,
                              child: Text(data['Item Name'],
                                  style: const TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(_FormatedPrice,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Warrenty: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(data['Warenty Period'],
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Condition: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(data['Condition'],
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Features: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(data['Item Features'],
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Suitable Vehicle Types: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                          const SizedBox(
                            width: 20,
                          ),
                         Expanded(
                              child: Text(
                                data['SuitableTypes'],
                                style: TextStyle(fontSize: 12),
                                softWrap: false,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis, // new
                              ),
                            ),
                        ],
                      ),
                    ),
                  const Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                          Text('Seller Details: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                          SizedBox(
                            width: 20,
                          ),
                          Text(data['Service Provider Name'],
                              style: TextStyle(fontSize: 12)),
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
                          Text('Contact No', style: TextStyle(fontSize: 12)),
                          SizedBox(
                            width: 20,
                          ),
                           Text(data['ServiceProviderContactNo'],
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children:  [
                          SizedBox(
                            width: 20,
                          ),
                          Text('Location', style: TextStyle(fontSize: 12)),
                          SizedBox(
                            width: 20,
                          ),
                          Text(data['ServiceProviderLocation'],
                              style: const TextStyle(fontSize: 12)),
                          Icon(
                            Icons.location_on,
                            size: 18,
                            color: Colors.deepPurple,
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text('Ratings & Comments: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 115, 113, 113))),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey),
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
              style: const NeumorphicStyle(color: Colors.purple),
              child: GestureDetector(
                onTap: () {
                  final curr = FirebaseAuth.instance.currentUser;
                  fs
                      .collection('VehicleOwner/${curr?.uid}/MessagesList')
                      .doc(data['Service Provider Id'])
                      .set({
                    "name": curr?.displayName ?? "No name",
                    'lastMsgTime': FieldValue.serverTimestamp(),
                    'isRespone': true,
                    "getterId": data['Service Provider Id'],
                    'imgUrl': "",
                    "sender": "VehicleOwner",
                    "getter": "vehicl parts providers"
                  }, SetOptions(merge: true));
                  fs
                      .collection(
                          'vehicl parts providers/${data['Service Provider Id']}/MessagesList')
                      .doc(curr?.uid)
                      .set({
                    "name": curr?.displayName ?? "No name",
                    'lastMsgTime': FieldValue.serverTimestamp(),
                    'isRespone': true,
                    "getterId": curr?.uid,
                    'imgUrl': curr?.photoURL ?? "",
                    "getter": "vehicl parts providers",
                    "sender": "VehicleOwner"
                  }, SetOptions(merge: true));

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Chatpage(
                                getter: "vehicl parts providers",
                                sender: "VehicleOwner",
                                getterId: data['Service Provider Id'],
                                getterName: data['Service Provider Name'],
                              )));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
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
              ),
            )),
            const SizedBox(
              width: 20,
            ),
            
            Expanded(
                child: NeumorphicButton(
              onPressed: () {
                today = DateTime(today.year, today.month, today.day, today.hour,
                    today.minute);
                String messagetitle = "You have new order";
                
                
                
                final curr = FirebaseAuth.instance.currentUser;
               
              //bill details
                  
              double quantity=OrderQuantity.toDouble();
              double sub_total=_price*quantity;
              double delivery_fee = 500;
                double total_fee = _price * OrderQuantity+
                    ((OrderQuantity== 1)
                        ? delivery_fee
                        : (OrderQuantity == 2)
                            ? 750
                            : 1000);
      

      print(total_fee);
                if(OrderQuantity>0){
               
                print('itemcode${data.id}');

                orders.add

                ({
                  'Item Name': data['Item Name'],
                  'Item Price': data['Item Price'],
                  'Item Qty': OrderQuantity.toString(),
                  'Imageurl': data['Imageurl'],
                  'Order Date Time': today,
                  'vehicle Owner Id': curr?.uid,
                  'Vehicle Owner Name': curr?.displayName,
                  'Service Provider Id': data['Service Provider Id'],
                  'Service Provider Name': data['Service Provider Name'],
                  'DeliveryFee':delivery_fee,
                  'SubTotal':sub_total,
                  'Total':total_fee,
                  'Oreder Status': OrderStatus,
                  "Ordernew": true,
                 "ItemCode":data.id
                  
                 
                  
                  

                });
                Notifications.add

                ({
                  'senderId':curr?.uid,
                  'receiverId':data['Service Provider Id'],
                  'messageTitle':messagetitle,
                  'messageBody':'${curr?.displayName} ordered ${data['Item Name']}',
                  'SendTime': today,
                  'Seen':false,

                });
                 
           
               

                var collection = FirebaseFirestore.instance.collection('VehicleParts');
                  collection 
                      .doc(data.id) 
                      .update({'StockQty' : RemainnigQty.toString()}) 
                      .then((_) => print('Success'))
                      .catchError((error) => print('Failed: $error')).
                  
                
                
              
             
             


              whenComplete(() {
                   
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => checkoutorder(
                              date: today,
                              price: _price,
                              providerName: data['Service Provider Name'],
                              qty: OrderQuantity,
                              item: data['Item Name'],
                              service_provider_id: data['Service Provider Id'],
                              contactNO: data['ServiceProviderContactNo'],
                            
                              
                             
                            )));
                  
                });

               
              }
              
              else{
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                        content: const Text(
                            "Enter the qty that you wish to buy"),
                        actions: <Widget>[
                         
                        ]),
                  );
              }
              },
              style: const NeumorphicStyle(color: Colors.purple),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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

