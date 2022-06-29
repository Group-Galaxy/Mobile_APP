import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'package:mypart/usermangment/welcomeScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  bool isDriver = false;
  bool ismechanic = false;
  bool isparts = false;

  startTimer() async {
    final prefs = await SharedPreferences.getInstance();

    isDriver = prefs.getBool('isDriver') ?? false;
    ismechanic = prefs.getBool('ismechanic') ?? false;
    isparts = prefs.getBool('isparts') ?? false;

    Timer(const Duration(seconds: 8), () {
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (_) => WelcomePage(
                    isDriver: isDriver,
                    ismechanic: ismechanic,
                    isparts: isparts,
                  )));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.network(
                'https://firebasestorage.googleapis.com/v0/b/mypart-86d9e.appspot.com/o/logo%2Flogo2.jpg?alt=media&token=48522a8f-53fb-4763-a58f-810de3b1f591',
                height: 500,
                width: 500,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Vehicle Breakdown Service',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ]),
          )),
    );
  }
}
