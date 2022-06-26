import 'dart:async';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mypart/buyer/productProvider.dart';
import 'package:mypart/buyer/products.dart';
import 'package:mypart/buyer/searchhome.dart';
import 'package:mypart/designs/bottombar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class productDetails extends StatefulWidget {
  @override
  State<productDetails> createState() => _productDetailsState();
}

class _productDetailsState extends State<productDetails> {

  
  @override

 

  Widget build(BuildContext context) {
    final _PriceFormat = NumberFormat('##,##,##0');
    var _productProvider=Provider.of<ProductProvider>(context);
    var data=_productProvider.ProductData;
    var _price = int.parse(data['Item Price']);

      String _FormatedPrice ='\Rs. ${_PriceFormat.format(_price)}';


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
            
         
          child:PhotoView(
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
                        Text(data['Item Name'],style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    
                   Row(
                    children: [
                    Text(_FormatedPrice ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    ],
                   ) ,

                  SizedBox(
                      height: 15,
                    ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                   
                      
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Warrenty: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Color.fromARGB(255, 115, 113, 113))),

                              SizedBox(
                                width: 20,
                              ),
                              Text(data['Warenty Period'],style: TextStyle(fontSize: 12)),
                            ],
                    
                  ),
                ),
                 Divider(color: Colors.grey),
                   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                   
                      
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Condition: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Color.fromARGB(255, 115, 113, 113))),

                              SizedBox(
                                width: 20,
                              ),
                              Text(data['Condition'],style: TextStyle(fontSize: 12)),
                            ],
                    
                  ),
                ),
                 Divider(color: Colors.grey)  , 
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                   
                      
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Features: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Color.fromARGB(255, 115, 113, 113))),

                              SizedBox(
                                width: 20,
                              ),
                              Text(data['Item Features'],style: TextStyle(fontSize: 12)),
                            ],
                            
                    
                  ),
                ),
                 Divider(color: Colors.grey) ,  
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                   
                      
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              
                              Text('Seller Details: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Color.fromARGB(255, 115, 113, 113))),

                              SizedBox(
                                width: 20,
                              ),
                              Text('J K Motors',style: TextStyle(fontSize: 12)),
                              
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
                       Text('Contact No: ',style: TextStyle(fontSize: 12)),
                      SizedBox(
                                width: 20,
                              ),
                              Text('0715978410',style: TextStyle(fontSize: 12)),
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
                               Text('Location',style: TextStyle(fontSize: 12)),
                    

                      SizedBox(
                                width: 20,
                              ),
                              Text('Wester,Gampha,Negambo',style: TextStyle(fontSize: 12)),
                                Icon(Icons.location_on, size:18, color: Colors.deepPurple,),
                   ],
                      
                          
                              
                              
                    
                  ),
                ),
                 
                 Divider(color: Colors.grey) ,  
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                   
                      
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                               Text('Ratings & Comments: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Color.fromARGB(255, 115, 113, 113))),
                               


                            ],
                    
                  ),
                ),
                 Divider(color: Colors.grey) , 

                  ],
                ),
              ),



            ),


            
          ],
        ),

        
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}
