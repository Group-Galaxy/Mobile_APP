import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mypart/buyer/productProvider.dart';
import 'package:mypart/buyer/productmoreinfo.dart';
import 'package:mypart/buyer/products.dart';
import 'package:path/path.dart';
import 'package:search_page/search_page.dart';
import 'package:intl/intl.dart';
class VehicleParts {
  final String Item_Name, Item_Category,Condition,price,Features;
 
  final DocumentSnapshot document;

VehicleParts({
  required this.Item_Name,required this.Item_Category,required this.Condition,required this.price,required this.Features, required this.document
  }
);
  
}

class SearchService{
  search({context, productList}){
    showSearch(
          context: context,
          delegate: SearchPage<VehicleParts>(
            onQueryUpdate: (s) => print(s),
            items: productList,
            searchLabel: 'Search auto parts',
            suggestion: SingleChildScrollView(child: ProductList(true)),
            failure: Center(
              child: Text('No item found :'),
            ),
            filter: (VehicleParts) => [
              VehicleParts.Item_Name,
              VehicleParts.Item_Category,
              VehicleParts.Features,
              
              
            ],
            builder: (VehicleParts) {

                final _PriceFormat = NumberFormat('##,##,##0');
                 var _price = int.parse(VehicleParts.price);

                      String _FormatedPrice =
                          '\Rs. ${_PriceFormat.format(_price)}';


              return InkWell(
                onTap: () {
                  
                },
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 4,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                    children: [
                      Container(
                        width: 180,
                        height: 120,
                        child: Image.network(VehicleParts.document['Imageurl']),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(_FormatedPrice, style:TextStyle(fontWeight: FontWeight.bold) ,),
                              Text(VehicleParts.Item_Name)
                            ],
                          ),
                          
                        ],
                      )
                    ],
                    
                   ),
                 ),
                  ),
                ),
              );
          
            }
          ),
        );
  }
}