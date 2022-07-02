import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mypart/repair_payment/repairUser_receipt.dart';

import 'package:flutter/cupertino.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:mypart/usermangment/usermodel.dart';

class Receipts extends StatefulWidget {
  const Receipts({Key? key}) : super(key: key);

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

  double inspectionvalue = 0.0;

  double discountvalue = 0.0;

  double resultValue = 0.0;

  double balanceValue = 0.0;
  User? currentAutoPartsProvider = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel CurrentServiceprovider = VehicleOwnerModel();
  CollectionReference repair =
      FirebaseFirestore.instance.collection('payments');
  VehicleOwnerModel loggedInUser = VehicleOwnerModel();
  final user = FirebaseAuth.instance.currentUser;

  // var _date = DateTime.now().toString();

  var currentUser = {};
  @override
  void initState() {
    super.initState();

    final data = FirebaseFirestore.instance
        .collection('VehicleOwner')
        .where("uid", isEqualTo: user!.uid)
        .get()
        .then((res) {
      print(res.docs.first.data()['firstName']);
      setState(() {
        currentUser = res.docs.first.data();
      });
    });
    print(data);
  }

  @override
  var today = DateTime.now();
  Widget build(BuildContext context) {
    print("uid " + user!.uid);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 213, 249),
        appBar: AppBar(
          title: Text('Receipt Details'),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: Card(
          child: SingleChildScrollView(
              child: Column(children: [
            GFListTile(
              color: GFColors.WHITE,
              titleText: 'User Name : ${currentUser['firstName']}',
            ),

            /* DateTimePicker(
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
                controller: _ServiceProviderName,
                decoration: InputDecoration(
                    icon: Icon(Icons.people),
                    labelText: ' Service Provider Name'))),
        Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextField(
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
        ),*/
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                    controller: _Inspection,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.description,
                          color: Colors.black,
                        ),
                        labelText: 'Inspection Value',
                        labelStyle: TextStyle(color: Colors.black)))),
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                    controller: _Discount,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.description,
                          color: Colors.black,
                        ),
                        labelText: 'Discount',
                        labelStyle: TextStyle(color: Colors.black)))),
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
            ButtonBar(children: [
              RaisedButton(
                  child: Text("Send Details"),
                  textColor: Colors.white,
                  color: Colors.purple,
                  onPressed: () {
                    inspectionvalue = double.parse(_Inspection.text);
                    discountvalue = double.parse(_Discount.text);

                    resultValue = (inspectionvalue - discountvalue);

                    setState(() {
                      balanceValue = resultValue;
                    });

                    /*final ServiceProviderName = _ServiceProviderName.text;
                final UserName = _UserName.text;
                final VehicleFault = _VehicleFault.text;
                final InspectionValue = _Inspection.text;
                final Discount = _Discount.text;
                final Balance = resultValue.toString();
                final Date = _date;

                createUser(
                  ServiceProviderName: ServiceProviderName,
                  UserName: UserName,
                  VehicleFault: VehicleFault,
                  InspectionValue: InspectionValue,
                  Discount: Discount,
                  Balance: Balance,
                  Date: Date,
                );*/

                    // print("the selected date is ${_date}");
                    /* Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => receiptUser(
                          /*ServiceProviderName: _ServiceProviderName.text,
                          UserName: _UserName.text,
                          VehicleFault: _VehicleFault.text,
                          InspectionValue: _Inspection.text,
                          Discount: _Discount.text,
                          Balance: resultValue.toString(),
                          Date: _date,*/
                          ))*/
                  })
            ])
          ])),
          elevation: 8,
          shadowColor: Colors.purple,
          margin: EdgeInsets.all(15),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.purple, width: 2)),
        ));
  }
}

Future createUser(
    {required String ServiceProviderName,
    UserName,
    VehicleFault,
    InspectionValue,
    Discount,
    Balance,
    Date}) async {
  final docUser = FirebaseFirestore.instance.collection('payments').doc();
  final json = {
    'serviceProviderName': ServiceProviderName,
    'userName': UserName,
    'vehicleFault': VehicleFault,
    'inspectionValue': InspectionValue,
    'discount': Discount,
    'balance': Balance,
    'date': Date,
  };

  /// Create doc & write data to Firebase
  await docUser.set(json);
}
