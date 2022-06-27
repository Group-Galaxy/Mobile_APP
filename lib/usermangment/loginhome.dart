import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypart/buyer/searchhome.dart';
import 'package:mypart/usermangment/login.dart';
import 'package:mypart/usermangment/usermodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel loggedInUser = VehicleOwnerModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
              
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              Text("${loggedInUser.email}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 15,
              ),
             GestureDetector(
            onTap: () {
             

            },
            child: new Align(
               
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.purple)),
                  child: Icon(
                    Icons.man,
                    color: Colors.purple,
                    size: 75,
                  ),
                )),
          ),
                            
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Repair vehicle'),
                            ),
                  
          GestureDetector(
            onTap: () {
             Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) =>Home ()));

            },
            child: new Align(
                
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.purple)),
                  child: Icon(
                    Icons.key,
                    color: Colors.purple,
                    size: 75,
                  ),
                )),
          ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Buy vehicle parts'),
                            ),
            ],
          ),
        ),
      ),
    );
      
  
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}