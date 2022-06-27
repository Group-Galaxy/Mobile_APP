import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mypart/gateway.dart';

import 'package:flutter/cupertino.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class receiptUser extends StatelessWidget {
  String Date,
      ServiceProviderName,
      UserName,
      VehicleFault,
      InspectionValue,
      Discount,
      Balance;

  receiptUser({
    required this.Date,
    required this.ServiceProviderName,
    required this.UserName,
    required this.VehicleFault,
    required this.InspectionValue,
    required this.Discount,
    required this.Balance,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 213, 249),
      appBar: AppBar(
        title: Text('Receipt'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Text('Date : ${Date}'),
            Text('Service Provider Name : ${ServiceProviderName}'),
            Text('User Name : ${UserName}'),
            Text('Vehicle Fault : ${VehicleFault}'),
            SizedBox(
              height: 20,
            ),
            Text('Inspection Value : ${InspectionValue}'),
            Text('Discount : ${Discount}'),
            Text('Balance : ${Balance}'),
            SizedBox(height: 20),
            Divider(color: Colors.black),
            ButtonBar(
              children: [
                RaisedButton(
                  child: Text("Pay"),
                  textColor: Colors.white,
                  color: Colors.purple,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => (Gateway())),
                    );
                  },
                ),
                RaisedButton(
                  child: Text("Report"),
                  textColor: Colors.white,
                  color: Colors.purple,
                  onPressed: () {
                    Navigator.pushNamed(context, '/report');
                    // CollectionReference _collectionRef =
                    //     FirebaseFirestore.instance.collection('payments');
                    // QuerySnapshot querySnapshot = await _collectionRef.get();
                    // final allData =
                    //     querySnapshot.docs.map((doc) => doc.data()).toList();
                    // print(allData);
                  },
                ),
              ],
            )
          ])),
    );
  }
}
