import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mypart/repairservice/repairProvider.dart';
import 'package:mypart/usermangment/usermodel.dart';
import 'package:mypart/usermangment/vehicle%20repair%20service%20provider/repairserviceprousermodel.dart';
import 'package:provider/provider.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key, required this.title}) : super(key: key);

  final String title;



  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  
  final vehiclePartsProvider = FirebaseAuth.instance.currentUser;
   VehicleOwnerModel loggedInUser = VehicleOwnerModel();
  void initState() {
   
  
    super.initState();
    FirebaseFirestore.instance
        .collection("VehicleOwner")
        .doc(vehiclePartsProvider!.uid)
        .get()
        .then((value) {
      this.loggedInUser = VehicleOwnerModel.fromMap(value.data());
      setState(() {});
    });
  }
  


  @override
  Widget build(BuildContext context) {
    var _repairProvider = Provider.of<RepairProvider>(context);
    var data = _repairProvider.serviceProviderData;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
                          width: width,
                          color: Color.fromARGB(255, 239, 234, 239),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                  Container(
                    width: width *0.9,
                    height: height * 0.8,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        
                        
                      ),
                      color: Color.fromARGB(255, 239, 175, 244),
                      elevation: 10,
                      child: Column(children: [
                            GFListTile(
                  color: GFColors.WHITE,
                  titleText: 'Booking Date : ${DateTime.now().year} / ${DateTime.now().month} / ${DateTime.now().day}',
                            ),
                            GFListTile(
                  color: GFColors.WHITE,
                  titleText: 'Vehicle Owner Name : ${loggedInUser.firstName} ${loggedInUser.secondName}',
                            ),
                            GFListTile(
                  color: GFColors.WHITE,
                  titleText: 'Location : ',
                            ),
                            GFListTile(
                  color: GFColors.WHITE,
                  titleText: 'Contact No : ${loggedInUser.contactNO}',
                            ),
                            GFListTile(
                  color: GFColors.WHITE,
                  titleText: 'Service provider Name : ${data['firstName']}',
                            ),
                           
                            Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                        //style: TextStyle(color: Colors.black),
                        
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.description,
                              color: Colors.black,
                            ),
                            labelText: 'vehicle No ',
                            labelStyle: TextStyle(color: Colors.black)))),
      
                             Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        //style: TextStyle(color: Colors.black),
                        
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.description,
                              color: Colors.black,
                            ),
                            labelText: 'vehicle Fault ',
                            labelStyle: TextStyle(color: Colors.black)))),
                            ButtonBar(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RaisedButton(
                        child: Text("save"),
                        textColor: Colors.white,
                        color: Colors.purple,
                        onPressed: () async {
                          
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RaisedButton(
                        child: Text("Cancel"),
                        textColor: Colors.white,
                        color: Colors.purple,
                        onPressed: () async {
                          
                        },
                      ),
                    ),
                  ],
                            ),
                          ],
                    ),
                  ),
                  )
                            ],
                          
                          ),
                          ),
      ),
                      
                
    );
  }
}
