import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'package:mypart/usermangment/welcomeScreen.dart';






class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(Duration(seconds: 10),()=>Navigator.push(context, CupertinoPageRoute(builder: (_)=>WelcomePage())));
    super.initState();

  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: Colors.white,
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.network('https://firebasestorage.googleapis.com/v0/b/mypart-86d9e.appspot.com/o/logo%2Flogo2.jpg?alt=media&token=48522a8f-53fb-4763-a58f-810de3b1f591'
              ,height: 500,width: 500,),
              const SizedBox(
                height: 10,
              ),
              Text('Vehicle Breakdown Service',
              style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              
              
          )]),
              )
              ),
              );
}}
