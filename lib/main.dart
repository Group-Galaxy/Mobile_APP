import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mypart/buyer/productProvider.dart';
import 'package:mypart/buyer/searchhome.dart';
import 'package:mypart/categories/categoryProvider.dart';
import 'package:mypart/dashboard/dashboard.dart';
import 'package:mypart/gateway.dart';

import 'package:mypart/seller/Items.dart';
import 'package:mypart/temp.dart';
import 'package:mypart/usermangment/splashScreen.dart';

import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'usermangment/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      "pk_test_51LDqSTEHLxB2oFbTzhAthLXp4T3ZNgcTJmXVsrMkDZ55jXJJmlBfV3z0Al7MdP6Qwl08Njzblt9WxsBmPrItwvYm00YaYiCVlU";
  //await Stripe.instance.applySettings();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCTRKcNzs4GL5wmLorgpfC_NW9nkGvUFWs",
      appId: "1:702680588073:android:ff86d9660e286c8baca138",
      messagingSenderId: "702680588073",
      projectId: "mypart-86d9e",
    ),
  );
  Provider.debugCheckInvalidValueType = null;
  runApp((MultiProvider(
    providers: [
      Provider(create: (_) => ProductProvider()),
      Provider(create: (_) => categoryprovider()),
    ],
    child: MyApp(),
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MySplashScreen(),
    );
  }
}
