import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mypart/buyer/productProvider.dart';
import 'package:mypart/categories/categoryProvider.dart';
import 'package:mypart/seller/ItemProvider.dart';
import 'package:mypart/usermangment/splashScreen.dart';
import 'package:mypart/usermangment/welcomeScreen.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
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
  await _configureLocalTimeZone();
  const initializationSettingsAndroid =
      AndroidInitializationSettings('icon_main');
  final initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {});
  final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await _notificationInitMethod(initializationSettings);
  Provider.debugCheckInvalidValueType = null;
  runApp((MultiProvider(
    providers: [
      Provider(create: (_) => ProductProvider()),
      Provider(create: (_) => categoryprovider()),
      Provider(create: (_) => ItemProvider())
    ],
    child: const MyApp(),
  )));
}

Future<void> _notificationInitMethod(
    InitializationSettings initializationSettings) async {
  try {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notipfication payload: $payload');
      }
    });
  } catch (e) {
    debugPrint("$e");
  }
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: WelcomePage(),
    );
  }
}
