import 'package:flutter/material.dart';
import 'package:mypart/buyer/products.dart';
import 'package:mypart/buyer/vehicle_parts_home.dart';
import 'package:mypart/categories/categoryProvider.dart';
import 'package:provider/provider.dart';

class ProductByCategory extends StatelessWidget {
  const ProductByCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<categoryprovider>(context);
    var data = productProvider.Selectedcategory;
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => VehiclePartsHome()));
              },
            ),
            title: Text(data!)),
        body: SingleChildScrollView(
          child: ProductList(true),
        ));
  }
}
