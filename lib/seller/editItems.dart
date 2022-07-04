import 'dart:io' as io;
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypart/seller/progressbar.dart';
import 'package:mypart/seller/uploadimage.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsprousermodel.dart';

import 'Items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Edit{
  
}
class EditItem extends StatefulWidget {
  DocumentSnapshot docid;
  
  EditItem({required this.docid});

  @override
  State<EditItem> createState() => _EditItemState();
}
class _EditItemState extends State<EditItem> {
   File? image;
   File? _image;
  final picker = ImagePicker();
  Storage _storage = new Storage();


  TextEditingController Item_Name = TextEditingController();
  TextEditingController Item_Price = TextEditingController();
  TextEditingController Item_Qty = TextEditingController();
  TextEditingController ItemFeatures=TextEditingController();
  TextEditingController Item_Brand=TextEditingController();
  TextEditingController SuitableTypes=TextEditingController();
  
  
  var  Selected_category;
  var Selected_period;
  var Downloadurl;
  var Selected_condition;
  
 /*List<String> _ItemCategory = <String>[
    'tyres',
    'engine and components',
    'battery',
    'Engine oil',
    'brake systems'
  ];*/
  var _firestoreInstance = FirebaseFirestore.instance;
  List _categoryList = [];
  fetchcategories() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("categories").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _categoryList.add(
          qn.docs[i]["Name"],
        );
        print(qn.docs[i]["Name"]);
      }
    });

    return qn.docs;
  }
 
 
  List<String> _warrentyPeriod = <String>[
    'no warrenty',
    '1 year',
    '2 years',
    '3 years',
    'More than 5 years',
    'Life time warrenty'
  ];
  
  List<String> _condition = <String>[
    'used',
    'new',
    
  ];
  var today = new DateTime.now();
  


  CollectionReference ref = FirebaseFirestore.instance.collection('VehicleParts');
 
  @override
  
  final vehiclePartsProvider = FirebaseAuth.instance.currentUser;
   UserModel loggedInUser = UserModel();
   
  

  
   void initState() async {
    fetchcategories();
   
    
    super.initState();
    FirebaseFirestore.instance
        .collection("vehicl parts providers")
        .doc(vehiclePartsProvider!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
       leading: new IconButton(
    icon: new Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () {
      Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) => Items()));
    },
  ), 
     
      title: Text("Edit Item"),
       
        actions: [
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'Item Name': Item_Name.text,
                'ItemBrand':Item_Brand.text,
                'Item Price': Item_Price.text,
                'StockQty':Item_Qty.text,
                'Item Features':ItemFeatures.text,
                'Item Category':  Selected_category.toString(),
                'Condition':Selected_condition.toString(),
                'Warenty Period':  Selected_period.toString(),
                
                'PostedDate':today,
                'SuitableTypes':SuitableTypes.text,
                'Service Provider Id':vehiclePartsProvider?.uid,
                'Service Provider Name':vehiclePartsProvider?.displayName,
                'ServiceProviderContactNo':loggedInUser.contactNO,
                'ServiceProviderLocation':loggedInUser.location,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Items()));
              });
            },
            child: Text("save"),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Items()));
              });
            },
            child: Text("delete"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           
            Padding(
                  padding: EdgeInsets.only(left: 10, right:10,bottom:5),
                  child: TextFormField(
                    controller: Item_Name,
                    validator:(value){
                      
  
                },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                     
                            ),
                    
                      labelText: 'Item Name',
                      
                     
    
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize:16,
                         ),
                    ),
                    ),

                    
                ),
               
               Padding(
                    padding: EdgeInsets.only(left: 10, right:10,bottom:5,top: 20),
                    child: TextFormField( //Item Brand
                      controller: Item_Brand,
                      
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                     borderRadius: BorderRadius.circular(100.0),
                  ),
                        labelText: 'Item Brand',
                         counterText: 'eg : Amaron, CEAT',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize:16,
                           ),
                      ),
                      ),
                     ),

                 Padding(
                    padding: EdgeInsets.only(left: 10, right:10,bottom:5),
                   child: TextFormField(
                        controller: Item_Price, //price
                        
                        inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                        ],
                          
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                     borderRadius: BorderRadius.circular(100.0),
                  ),
                          labelText: 'Item Price',
                          prefixText: 'Rs.',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize:16,
                             ),
                        ),
                        keyboardType: TextInputType.number,
                        ),
                 ),
                  SizedBox(
                  height:20,
                 ),
         
                   Padding(
                      padding: EdgeInsets.only(left: 10, right:10,bottom:8),
                     child: TextFormField(
                          controller: Item_Qty,
                         
                        
                          inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
                 ],
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                     borderRadius: BorderRadius.circular(100.0),
                  ),
                            labelText: 'Item Quantity',
                            
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize:16,
                               ),
                          ),
                          keyboardType: TextInputType.number,
                          ),
                   ),

                   SizedBox(
                  height:20,
                 ),
                            Padding(
                           padding: EdgeInsets.only(left: 10, right:10,bottom:8),
                          
                          child: DropdownButtonFormField(
      
                              dropdownColor: Colors.white,
                              
                              
                              icon: Icon(Icons.keyboard_arrow_down),
                              items: _categoryList
                                  .map((value) => DropdownMenuItem(
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        value: value,
                                      ))
                                  .toList(),
                              onChanged: (Svalue) {
                                
                                setState(() {
                                  Selected_category = Svalue;
                                });
                              },
                                  decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                     borderRadius: BorderRadius.circular(100.0),
                  ),
                                    ),
                              value: Selected_category,
                              isExpanded: false,
                              hint: Text(
                                'Choose Item Category',
                                style: TextStyle(color: Colors.black),
                                
                              ),
                            ),
                        ),
                     
                        SizedBox(
                                    height:20,
                                  ),
                        
                       Padding(
                            padding: EdgeInsets.only(left: 10, right:10,bottom:8),
                            child: DropdownButtonFormField(
      
                                dropdownColor: Colors.white,
                                
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: _condition
                                    .map((value) => DropdownMenuItem(
                                          child: Text(
                                            value,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          value: value,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                 
                                  setState(() {
                                    Selected_condition= value;
                                  });
                                },
                                decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                     borderRadius: BorderRadius.circular(100.0),
                  ),
                                ),
                                value: Selected_condition,
                                isExpanded: false,
                                hint: Text(
                                  'Condition',
                                  style: TextStyle(color: Colors.black),
                                  
                                ),
                              ),
                          ),
                        
                        SizedBox(
                                    height:20,
                                  ),
                        
                       Padding(
                            padding: EdgeInsets.only(left: 10, right:10,bottom:8),
                            child: DropdownButtonFormField(
      
                                dropdownColor: Colors.white,
                                
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: _warrentyPeriod
                                    .map((value) => DropdownMenuItem(
                                          child: Text(
                                            value,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          value: value,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                 
                                  setState(() {
                                    Selected_period = value;
                                  });
                                },
                                decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                     borderRadius: BorderRadius.circular(100.0),
                  ),
                                ),
                                value: Selected_period,
                                isExpanded: false,
                                hint: Text(
                                  'Warrenty Period',
                                  style: TextStyle(color: Colors.black),
                                  
                                ),
                              ),
                          ),
                        
                      SizedBox(
                  height:20,
                 ),
                    Padding(
                    padding: EdgeInsets.only(left: 10, right:10,bottom:5),
                   child: TextFormField(
                        controller: ItemFeatures,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                     borderRadius: BorderRadius.circular(100.0),
                  ),
                        
                          labelText: 'Item Features',
                          counterText: 'eg :capacity,power out ',
                          
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize:16,
                             ),
                        ),
                        ),
                 ),
                     
                      SizedBox(
                  height:20,
                 ),
                    Padding(
                    padding: EdgeInsets.only(left: 10, right:10,bottom:5),
                   child: TextFormField(
                        controller: SuitableTypes,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                     borderRadius: BorderRadius.circular(100.0),
                  ),
                        
                          labelText: 'Suitable Vehicle Types',
                          counterText: 'eg :Daewoo Matitz,Hyundai Santro-Xing,',
                          
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize:16,
                             ),
                        ),
                        ),
                 ),

                   SizedBox(
                  height:20,
                 ),

                 // Image upload
              
          ],
        ),
      ),
    );
  }
}
