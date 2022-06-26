

import 'package:flutter/material.dart';
import 'package:mypart/buyer/products.dart';
import 'package:mypart/buyer/searchhome.dart';
import 'package:mypart/categories/categoryProvider.dart';
import 'package:provider/provider.dart';

class ProductByCategory extends StatelessWidget {
  const ProductByCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _productProvider=Provider.of<categoryprovider>(context);
    var data=_productProvider.Selectedcategory;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Home()));
          },
        ),
        title:Text(data! )
            
      ),
      body: SingleChildScrollView(child: ProductList(true),)
    );
    
  }
}