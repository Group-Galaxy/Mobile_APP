//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:mypart/buyer/products.dart';
import 'package:mypart/categories/categories.dart';
import 'package:mypart/categories/categoryProvider.dart';
import 'package:mypart/designs/appbar.dart';

import 'package:mypart/designs/bottombar.dart';
import 'package:intl/intl.dart';
import 'package:mypart/services/searchService.dart';
import 'package:provider/provider.dart';

import '../firebaseservice.dart';

class VehiclePartsHome extends StatefulWidget {
  @override
  _VehiclePartsHomeState createState() => _VehiclePartsHomeState();
}

class _VehiclePartsHomeState extends State<VehiclePartsHome> {
  final List<String> _carouselImages = [];
  final _dotPosition = 0;
  final List _products = [];
  final _firestoreInstance = FirebaseFirestore.instance;
  final FirebaseService _service = FirebaseService();
  final SearchService _serach = SearchService();

  static List<VehicleParts> items = [];

  @override
  @override
  Widget build(BuildContext context) {
    final formate = NumberFormat('##,##,##0');

    var catProvider = Provider.of<categoryprovider>(context);
    catProvider.ClearSelectedCategory();
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: SafeArea(child: Customappbar()),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Column(
                  children: const [
                    SizedBox(
                      height: 10.0,
                    ),
                    Categories(),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ProductList(false),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
