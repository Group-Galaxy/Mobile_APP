import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mypart/seller/Items.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsprousermodel.dart';
import 'package:path/path.dart';
import 'uploadimage.dart';


import 'dart:async';
import 'dart:developer';
import 'dart:io' as io;

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import 'progressbar.dart';

class AddItems extends StatefulWidget {
  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
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
   
  

  
   void initState() {
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


  final _key = GlobalKey<FormState>();
  Widget build(BuildContext context) {

    final vehiclePartsProvider = FirebaseAuth.instance.currentUser;
 
   return Scaffold(
   
   
      appBar: AppBar(
        
        title: Text("Add new Item"),
        automaticallyImplyLeading: false,
  leading: new IconButton(
    icon: new Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () {
      Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) => Items()));
    },
  ), 
       
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _key,
            child: Column(
                children:<Widget> [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right:10,bottom:5,top: 20),
                    child: TextFormField( //Item Name
                      controller: Item_Name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name of the item';
                        }
                        return null;
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
                        labelText: 'Item Name*',
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
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the price of item';
                        }
                        return null;
                        },
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
                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the quantity that you wish to sell ';
                        }
                        return null;
                        },
                        
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
                Padding(
                    padding: EdgeInsets.only(left: 10, right:10,bottom:5),
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              color: Colors.black12,
                              child: image == null
                                  ? Icon(
                                      Icons.image,
                                      size: 100,
                                    )
                                  : Image.file(
                                      image!,
                                      fit: BoxFit.fill,
                                    )),
                                    
                       ElevatedButton.icon(
                        
                          
                          style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  fixedSize: const Size(120, 40),
                          ),
                          
                          onPressed: () {
                            _storage.getImage(context).then((file) {
                              setState(() {
                                image = File(file.path);
                                print(file.path);
                              });
                            });
                          },
                         icon: Icon( 
                        Icons.upload,
                        size: 24.0,
                      ),
                      label: Text('Pick image'),
          
                            
                          ),
                       ],
                      ),
                      TextButton(
                        
                          onPressed: () async {
                            if (image == null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("No Image was selected")));
                                  return null;
                            }
                          
                              
                              showDialog(context: context, builder: (context) => ProgressBar()) ;

                              firebase_storage.UploadTask uploadTask;
                              Random rand = new Random();

                              _image = File(image!.path);
                              firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
                                  .ref()
                                  .child('photos')
                                  .child('/${DateTime.now().toIso8601String()}');

                              final metadata = firebase_storage.SettableMetadata(
                                  contentType: 'image/jpeg',
                                  customMetadata: {'picked-file-path': image!.path});

                              if (kIsWeb) {
                                uploadTask = ref.putData(await image!.readAsBytes(), metadata);
                              } else {
                                uploadTask = ref.putFile(io.File(image!.path), metadata);
                              }
                              uploadTask.snapshotEvents.listen((event) {
                                progress.value =
                                    (100 * (event.bytesTransferred / event.totalBytes)).round();
                                print('${(100 * (event.bytesTransferred / event.totalBytes)).round()}');
                              });
                          

                              await uploadTask.whenComplete(()async {
                                    Downloadurl= await ref.getDownloadURL();
                                  
                                  
                                Navigator.pop(context);
                                print('finished upload');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text("Image uploaded successfully")));
                                progress.value = 0;
                              });
                              
                             
                              
                            
                              
                          },
                            
                          
                          child: Text('Upload Image', style: TextStyle(fontSize: 16, color: Colors.purple),)
                          )
                    ],
                  ),
                 ),
                 SizedBox(
                  height:20,
                 ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                       
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  fixedSize: const Size(120, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            
                          
                    onPressed: () {
                          if (_key.currentState!.validate()){
                   today = new DateTime(today.year, today.month, today.day,);         
                ref.add({
                'Item Name': Item_Name.text,
                'ItemBrand':Item_Brand.text,
                'Item Price': Item_Price.text,
                'StockQty':Item_Qty.text,
                'Item Features':ItemFeatures.text,
                'Item Category':  Selected_category.toString(),
                'Condition':Selected_condition.toString(),
                'Warenty Period':  Selected_period.toString(),
                'Imageurl':Downloadurl.toString(),
                'PostedDate':today,
                'SuitableTypes':SuitableTypes.text,
                'Service Provider Id':vehiclePartsProvider?.uid,
                'Service Provider Name':vehiclePartsProvider?.displayName,
                'ServiceProviderContactNo':loggedInUser.contactNO,
                'ServiceProviderLocation':loggedInUser.location,
                
                 
                
              }
              )
             /* users.doc(loggedInUser.uid).collection('MyAutoParts').add({
                'ItemName': Item_Name.text,
                'ItemBrand':Item_Brand.text,
                'ItemPrice': Item_Price.text,
                'StockQty':Item_Qty.text,
                'ItemFeatures':ItemFeatures.text,
                'ItemCategory':  Selected_category.toString(),
                'Condition':Selected_condition.toString(),
                'WarentyPeriod':  Selected_period.toString(),
                'SuitableTypes':SuitableTypes.text,
                'Imageurl':Downloadurl.toString(),
                'PostedDate':today,
                
              })*/.
              whenComplete(() {
                showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                
                  content: const Text("You added the item sucessfully"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                          Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Items()));
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
                   
                 }
           
                    },
                    child: Text('Save'),

),
                      ),


 SizedBox(
  width: 20,
 ),
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   ElevatedButton(
  style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  fixedSize: const Size(120, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            
                      onPressed: () {
  
                         Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) => Items()));
  
                      },
  
                      child: Text('Cancel'),
                     
  
  
  ),
)
                    ]
                    
                   


                 ),   
                      
                ]
                
                
            ),
            
                
                
                
          ),
        
          
          ),
      ),
        
   );
   
  }
Future getImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile;
    } else {
      return null;
    }
  }

  Future uploadFile(File file, context) async {
    if (file == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No file was selected")));
      return null;
    }
 
} 
}


