import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mypart/buyer/productProvider.dart';
import 'package:mypart/firebaseservice.dart';
import 'package:provider/provider.dart';

import '../services/searchService.dart';

class Customappbar extends StatefulWidget {
  const Customappbar({Key? key}) : super(key: key);

  @override
  State<Customappbar> createState() => _CustomappbarState();
}

class _CustomappbarState extends State<Customappbar> {

    static List<VehicleParts> items = [];
 
  FirebaseService _service=FirebaseService();
  SearchService _serach=SearchService();

   void initState() {
   _service.VehicleItems.get().then((QuerySnapshot snapshot){
    
    snapshot.docs.forEach((doc) {
      setState(() {
        items.add(
          VehicleParts(
            document: doc,
            Item_Name: doc['Item Name'],
            price: doc['Item Price'],
            Item_Category:doc['Item Category'] ,
            Condition:doc['Condition'] ,
            Features:doc['Item Features'] ,
           
            )
        );
      });
    });
    
   }
   );
    
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
      var provider=Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
 
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onTap: (() {
                              _serach.search(context: context,productList: items,
                              provider: provider,
                              );
                              }),
                              
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  labelText: 'Find auto parts',
                                  border: OutlineInputBorder(
                                    )
                                 ),
                              
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
      ),
      ),
     
    );
  }
}