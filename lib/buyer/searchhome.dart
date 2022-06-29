//import 'dart:html';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypart/buyer/products.dart';
import 'package:mypart/categories/categories.dart';
import 'package:mypart/categories/categoryProvider.dart';
import 'package:mypart/designs/appbar.dart';

import 'package:mypart/designs/bottombar.dart';
import 'package:mypart/seller/Items.dart';
import 'package:intl/intl.dart';
import 'package:mypart/services/searchService.dart';
import 'package:provider/provider.dart';

import '../firebaseservice.dart';
import 'productmoreinfo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  FirebaseService _service = FirebaseService();
  SearchService _serach = SearchService();

  static List<VehicleParts> items = [];

  @override
  @override
  Widget build(BuildContext context) {
    final _formate = NumberFormat('##,##,##0');

    var _catProvider = Provider.of<categoryprovider>(context);
    _catProvider.ClearSelectedCategory();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: SafeArea(child: Customappbar()),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Column(
                  children: [
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
            SizedBox(
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
