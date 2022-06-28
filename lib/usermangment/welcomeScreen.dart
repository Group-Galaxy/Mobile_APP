import 'dart:html';

import 'package:flutter/material.dart';

import 'package:mypart/usermangment/login.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsProviderLogin.dart';
import 'package:mypart/usermangment/vehicle%20repair%20service%20provider/repairserviceproLogin.dart';



class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          
         
            
              
             color: Colors.white,
              
            
          

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: 99,),
                  Text('Welcome', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: Colors.black),),

                  SizedBox(height: 100,
                        
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/mypart-86d9e.appspot.com/o/logo%2Flogo2.jpg?alt=media&token=48522a8f-53fb-4763-a58f-810de3b1f591',
                          fit: BoxFit.contain,
                        )),

                   Text('Choose the user Type', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                  SizedBox(height: 80,),
                  Container(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
            onTap: () {
             Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
//user
            },
            child: new Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 2, color: Colors.purple)),
                  child: Icon(
                    Icons.person_pin,
                    color: Colors.purple,
                    size: 20,
                  ),
                )),
          ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Text('vehicle owner',
                                style: TextStyle(
                                  fontSize: 9, fontWeight: FontWeight.bold,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(child: Text('Do you need to repair your vehicle?', style: TextStyle(
                              fontSize: 8, fontStyle:FontStyle.italic),)),
                            SizedBox(child: Text('Do you need to buy vehicle parts?', style: TextStyle(
                              fontSize: 8, fontStyle:FontStyle.italic),)),
                            SizedBox(child: Text('Log from here...', style: TextStyle(
                              fontSize: 8, fontStyle:FontStyle.italic),)),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: [
                             GestureDetector(
            onTap: () {
             Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) => PartsProviderLogin()));

            },

            child: new Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.purple)),
                  child: SizedBox(
                    child: Icon(
                      Icons.shopping_cart_checkout_sharp,
                      color: Colors.purple,
                      size: 20,
                    ),
                  ),
                )),
          ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Text('vehicle parts provider',
                                style: TextStyle(
                                  fontSize: 9, fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                            SizedBox(child: Text('Do you wish to give your service \n by providing vehicle parts?', style: TextStyle(
                              fontSize: 8, fontStyle:FontStyle.italic
                            ),)),
                            SizedBox(child: Text('Log from here...', style: TextStyle(
                              fontSize: 8, fontStyle:FontStyle.italic
                            ),)),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: [
                             GestureDetector(
            onTap: () {
             Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) => RepairServiceProviderLogin()));

            },

            child: new Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.purple)),
                  child: Icon(
                    Icons.car_repair,
                    color: Colors.purple,
                    size: 20,
                  ),
                )),
          ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Text('vehicle repair service provider',
                                style: TextStyle(
                                  fontSize: 9, fontWeight: FontWeight.bold,
                                ),
                                ),
                              ),
                            ),
                             SizedBox(child: Text('Do you wish to give your service \n by repairing vehicles?', style: TextStyle(
                              fontSize: 8, fontStyle:FontStyle.italic),)),
                            SizedBox(child: Text('Log from here...', style: TextStyle(
                              fontSize: 8, fontStyle:FontStyle.italic),)),
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