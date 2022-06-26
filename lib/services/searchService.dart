import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:search_page/search_page.dart';

class VehicleParts {
  final String Item_Name, Item_Category,Condition,price,Features;
  final num PostedDate;
  final DocumentSnapshot document;

VehicleParts({
  required this.Item_Name,required this.Item_Category,required this.Condition,required this.price,required this.PostedDate,required this.Features, required this.document
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
            suggestion: Center(
              child: Text('Filter items by categoty and  name'),
            ),
            failure: Center(
              child: Text('No person found :'),
            ),
            filter: (VehicleParts) => [
              VehicleParts.Item_Name,
              VehicleParts.Item_Category,
              VehicleParts.Features,
              
              
            ],
            builder: (VehicleParts) => ListTile(
              title: Text(VehicleParts.Item_Name),
              
            ),
          ),
        );
  }
}