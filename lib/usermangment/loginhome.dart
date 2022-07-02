import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypart/buyer/vehicle_parts_home.dart';
import 'package:mypart/repairservice/repairhome.dart';
import 'package:mypart/usermangment/splashScreen.dart';
import 'package:mypart/usermangment/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../reviews/review_give_screen.dart';
import '../reviews/review_show_screen.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  _DriverHomeState createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  User? user = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel loggedInUser = VehicleOwnerModel();
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAc();
  }

  setAc() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDriver', true);
    await prefs.setBool('ismechanic', false);
    await prefs.setBool('isparts', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                 Navigator.push(
                      context, MaterialPageRoute(builder: (_) => RepairHomeScreen()));
                },
                child: Align(
                    child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.purple)),
                  child: const Icon(
                    Icons.car_repair,
                    color: Colors.purple,
                    size: 75,
                  ),
                )),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Repair vehicle'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => VehiclePartsHome()));
                },
                child: Align(
                    child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.purple)),
                  child: const Icon(
                    Icons.shopping_cart_checkout,
                    color: Colors.purple,
                    size: 75,
                  ),
                )),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Buy vehicle parts'),
              ),
              TextButton(
                onPressed: () {
                  prefs.setBool('isDriver', false);
                  prefs.setBool('ismechanic', false);
                  prefs.setBool('isparts', false);
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                          builder: (_) => const MySplashScreen()));
                },
                child: const Text("Log Out"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ReviewGiveScreen(
                                getter: "vehicl parts providers",
                                getterId: "pMwHN6sWTxYSSzKXlRe6bTmWUAZ2",
                              )));
                },
                child: const Text("Review put"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ReviewShowScreen(
                          getter: "vehicl parts providers",
                          sender: "VehicleOwner",
                          getterId: "pMwHN6sWTxYSSzKXlRe6bTmWUAZ2",
                        ),
                      ));
                },
                child: const Text("Review show"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
