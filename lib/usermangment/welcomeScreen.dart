import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypart/dashboard/dashboard.dart';
import 'package:mypart/seller/Items.dart';

import 'package:mypart/usermangment/login.dart';
import 'package:mypart/usermangment/loginhome.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsProviderLogin.dart';
import 'package:mypart/usermangment/vehicle%20repair%20service%20provider/repairserviceproLogin.dart';

import '../dashboard/repairserviceDashboard.dart';

class WelcomePage extends StatefulWidget {
  final bool? isDriver;
  final bool? ismechanic;
  final bool? isparts;
  const WelcomePage({Key? key, this.isDriver, this.ismechanic, this.isparts})
      : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var curr = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    bool isDrivern = widget.isDriver ?? false;
    bool ismechanicn = widget.ismechanic ?? false;
    bool ispartsn = widget.isparts ?? false;

    if (isDrivern) {
      return const DriverHome();
    }
    if (ismechanicn) {
      return  RepaiirDashboard(title: 'Dashboard',);
    }
    if (ispartsn) {
      return const NavSide(
        title: 'Dashboard',
      );
    } else {
      return Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 99,
                    ),
                    const Text(
                      'Welcome',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                        height: 100,
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/mypart-86d9e.appspot.com/o/logo%2Flogo2.jpg?alt=media&token=48522a8f-53fb-4763-a58f-810de3b1f591',
                          fit: BoxFit.contain,
                        )),
                    const Text(
                      'Choose the user Type',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    SizedBox(
                      height: 500,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const LoginScreen()));
//user
                                },
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      margin: const EdgeInsets.all(20),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 2, color: Colors.purple)),
                                      child: const Icon(
                                        Icons.person_pin,
                                        color: Colors.purple,
                                        size: 20,
                                      ),
                                    )),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  child: Text(
                                    'vehicle owner',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  child: Text(
                                'Do you need to repair your vehicle?',
                                style: TextStyle(
                                    fontSize: 8, fontStyle: FontStyle.italic),
                              )),
                              const SizedBox(
                                  child: Text(
                                'Do you need to buy vehicle parts?',
                                style: TextStyle(
                                    fontSize: 8, fontStyle: FontStyle.italic),
                              )),
                              const SizedBox(
                                  child: Text(
                                'Log from here...',
                                style: TextStyle(
                                    fontSize: 8, fontStyle: FontStyle.italic),
                              )),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const PartsProviderLogin()));
                                },
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      margin: const EdgeInsets.all(20),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              width: 2, color: Colors.purple)),
                                      child: const SizedBox(
                                        child: Icon(
                                          Icons.shopping_cart_checkout_sharp,
                                          color: Colors.purple,
                                          size: 20,
                                        ),
                                      ),
                                    )),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  child: Text(
                                    'vehicle parts provider',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  child: Text(
                                'Do you wish to give your service \n by providing vehicle parts?',
                                style: TextStyle(
                                    fontSize: 8, fontStyle: FontStyle.italic),
                              )),
                              const SizedBox(
                                  child: Text(
                                'Log from here...',
                                style: TextStyle(
                                    fontSize: 8, fontStyle: FontStyle.italic),
                              )),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const RepairServiceProviderLogin()));
                                },
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      margin: const EdgeInsets.all(20),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              width: 2, color: Colors.purple)),
                                      child: const Icon(
                                        Icons.car_repair,
                                        color: Colors.purple,
                                        size: 20,
                                      ),
                                    )),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  child: Text(
                                    'vehicle repair service provider',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  child: Text(
                                'Do you wish to give your service \n by repairing vehicles?',
                                style: TextStyle(
                                    fontSize: 8, fontStyle: FontStyle.italic),
                              )),
                              const SizedBox(
                                  child: Text(
                                'Log from here...',
                                style: TextStyle(
                                    fontSize: 8, fontStyle: FontStyle.italic),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
