import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:mypart/gateway.dart';

class checkoutreceipt extends StatelessWidget {
  String Date,
      ServiceProviderID,
      UserName,
      Item,
      Quantity,
      ContactNumber,
      SubTotal,
      DiliveryFee,
      Discount,
      Balance;

  checkoutreceipt({
    required this.Date,
    required this.ServiceProviderID,
    required this.UserName,
    required this.Item,
    required this.Quantity,
    required this.ContactNumber,
    required this.SubTotal,
    required this.DiliveryFee,
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
            Text('Service Provider ID : ${ServiceProviderID}'),
            Text('User Name : ${UserName}'),
            Text('Item : ${Item}'),
            Text('Item : ${Quantity}'),
            Text('Contact Number : ${ContactNumber}'),
            SizedBox(
              height: 20,
            ),
            Text('Sub Total : ${SubTotal}'),
            Text('Dilivery Fee : ${DiliveryFee}'),
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
                  onPressed: () async {
                    CollectionReference _collectionRef =
                        FirebaseFirestore.instance.collection('orderpayments');
                    QuerySnapshot querySnapshot = await _collectionRef.get();
                    final allData =
                        querySnapshot.docs.map((doc) => doc.data()).toList();
                    print(allData);
                  },
                ),
              ],
            )
          ])),
    );
  }
}
