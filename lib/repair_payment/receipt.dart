import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mypart/dashboard/repairserviceDashboard.dart';
import 'package:mypart/repair_payment/repairUser_receipt.dart';

import 'package:flutter/cupertino.dart';
import 'package:date_time_picker/date_time_picker.dart';

class Receipts extends StatefulWidget {
  //look repaireserviceDashboard to look booking_id
  String booking_id = "QgletgMwmVmzk9mdATif";
  Receipts({required this.booking_id});

  @override
  State<Receipts> createState() => _ReceiptsState();
}

class _ReceiptsState extends State<Receipts> {
  var _date = DateTime.now().toString();
  TextEditingController _ServiceProviderName = new TextEditingController();
  TextEditingController _UserName = new TextEditingController();
  TextEditingController _VehicleFault = new TextEditingController();
  TextEditingController _Inspection = new TextEditingController();
  TextEditingController _Discount = new TextEditingController();
  TextEditingController _balance = new TextEditingController();
  TextEditingController _ServiceProviderID = new TextEditingController();

  double inspectionvalue = 0.0;

  double discountvalue = 0.0;

  double resultValue = 0.0;

  double balanceValue = 0.0;

  void getData() async {
    var res = await FirebaseFirestore.instance
        .collection("BookingDetails")
        .doc(widget.booking_id)
        .get()
        .then((value) {
      print(value.data());
      setState(() {
        _ServiceProviderName.text = value.data()!["ServiceProviderName"];
        _UserName.text = value.data()!["customerNmae"];
        _VehicleFault.text = value.data()!["vehicleFault"];
        _ServiceProviderID.text = value.data()!["ServiceProviderID"];
      });
    });

    print(res);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // getData();
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 213, 249),
        appBar: AppBar(
          title: Text('Receipt Details'),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          DateTimePicker(
            initialValue: DateTime.now().toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            icon: Icon(Icons.calendar_today),
            dateLabelText: 'Expiration Date',
            onChanged: (val) {
              print(_date);
              setState(() {
                _date = val.toString().substring(0, 10);
              });
              print(_date);
            },
            validator: (val) {
              return null;
            },
            onSaved: (val) {},
          ),
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                  readOnly: true,
                  controller: _ServiceProviderName,
                  decoration: InputDecoration(
                      icon: Icon(Icons.people),
                      labelText: ' Service Provider Name'))),
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                  readOnly: true,
                  controller: _UserName,
                  decoration: InputDecoration(
                      icon: Icon(Icons.people), labelText: 'User name'))),
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                  controller: _VehicleFault,
                  decoration: InputDecoration(
                      icon: Icon(Icons.description),
                      labelText: 'Vehicle Fault'))),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _Inspection,
                  decoration: InputDecoration(
                      icon: Icon(Icons.description),
                      labelText: 'Inspection Value'))),
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _Discount,
                  decoration: InputDecoration(
                      icon: Icon(Icons.description), labelText: 'Discount'))),
          SizedBox(
            height: 20,
          ),
          Text("Balance = $balanceValue",
              style: TextStyle(
                fontSize: 20,
              )),
          Divider(color: Colors.black),
          SizedBox(
            height: 20,
          ),
          ButtonBar(
            children: [
              RaisedButton(
                child: Text("Send Details"),
                textColor: Colors.white,
                color: Colors.purple,
                onPressed: () async {
                  inspectionvalue = double.parse(_Inspection.text);
                  discountvalue = double.parse(_Discount.text);

                  /* resultValue =
                      balanceValue - (inspectionvalue - discountvalue);*/

                  resultValue = (inspectionvalue - discountvalue);

                  setState(() {
                    balanceValue = resultValue;
                  });

                  final ServiceProviderName = _ServiceProviderName.text;
                  final UserName = _UserName.text;
                  final VehicleFault = _VehicleFault.text;
                  final InspectionValue = _Inspection.text;
                  final Discount = _Discount.text;
                  final Balance = resultValue.toString();
                  final Date = _date;
                  final ServiceProviderID = _ServiceProviderID.text;

                  createUser(
                    ServiceProviderID: ServiceProviderID,
                    ServiceProviderName: ServiceProviderName,
                    UserName: UserName,
                    VehicleFault: VehicleFault,
                    InspectionValue: InspectionValue,
                    Discount: Discount,
                    Balance: Balance,
                    Date: Date,
                  );

                  print("the selected date is ${_date}");

                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RepaiirDashboard(
                            title: '',
                          )));
                },
              ),
            ],
          )
        ])));
  }

  Future createUser(
      {required String ServiceProviderID,
      ServiceProviderName,
      UserName,
      VehicleFault,
      InspectionValue,
      Discount,
      Balance,
      Date}) async {
    final docUser = FirebaseFirestore.instance.collection('payments').doc();

    final json = {
      'ServiceProviderID': ServiceProviderID,
      'serviceProviderName': ServiceProviderName,
      'userName': UserName,
      'vehicleFault': VehicleFault,
      'inspectionValue': InspectionValue,
      'discount': Discount,
      'balance': Balance,
      'date': Date,
      "is_paid": false,
      'DocID': docUser.id
    };

    /// Create doc & write data to Firebase
    await docUser.set(json);
  }
}
