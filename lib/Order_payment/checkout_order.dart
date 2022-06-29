/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypart/Order_payment/checkout_receipt.dart';
import 'package:mypart/usermangment/usermodel.dart';

class checkoutorder extends StatefulWidget {
  const checkoutorder({Key? key}) : super(key: key);

  @override
  State<checkoutorder> createState() => _checkoutorderState();
}

class _checkoutorderState extends State<checkoutorder> {
  User? currentAutoPartsProvider = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel CurrentServiceprovider = VehicleOwnerModel();
  CollectionReference orders =
      FirebaseFirestore.instance.collection('orderpayments');

  var _date = DateTime.now().toString();
  TextEditingController _ServiceProviderID = new TextEditingController();
  TextEditingController _UserName = new TextEditingController();
  TextEditingController _Item = new TextEditingController();
  TextEditingController _Quantity = new TextEditingController();
  TextEditingController _ContactNumber = new TextEditingController();
  TextEditingController _SubTotal = new TextEditingController();
  TextEditingController _DiliveryFee = new TextEditingController();
  TextEditingController _Discount = new TextEditingController();
  TextEditingController _balance = new TextEditingController();

  double subTotal = 0.0;

  double diliveryFee = 0.0;

  double discountValue = 0.0;

  double resultValue = 0.0;

  double balanceValue = 0.0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Order Details")
        .doc(currentAutoPartsProvider!.displayName)
        .get()
        .then((value) {
      this.CurrentServiceprovider = VehicleOwnerModel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 213, 249),
      appBar: AppBar(
        title: Text('Checkout Order'),
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
          dateLabelText: ' Date',
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
        FutureBuilder<QuerySnapshot>(
          future: orders
              .where(
                'Service Provider Name',
                isEqualTo: CurrentServiceprovider.firstName,
              )
              .where('Oreder Status', isEqualTo: 'Pending')
              .get(),
          builder:
             (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            /* Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: TextField(
                      controller: _ServiceProviderID,
                      decoration: InputDecoration(
                          icon: Icon(Icons.people),
                          labelText: ' Service Provider Name')));*/
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                    controller: _UserName,
                    decoration: InputDecoration(
                        icon: Icon(Icons.people), labelText: 'User name')));
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                    controller: _Item,
                    decoration: InputDecoration(
                        icon: Icon(Icons.description), labelText: 'Item ')));
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                    controller: _Quantity,
                    decoration: InputDecoration(
                        icon: Icon(Icons.description),
                        labelText: 'Quantity ')));
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                    controller: _ContactNumber,
                    decoration: InputDecoration(
                        icon: Icon(Icons.description),
                        labelText: 'Contact Number')));
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                    controller: _SubTotal,
                    decoration: InputDecoration(
                        icon: Icon(Icons.description),
                        labelText: 'Sub Total')));
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                    controller: _DiliveryFee,
                    decoration: InputDecoration(
                        icon: Icon(Icons.description),
                        labelText: 'Dilivery Fee')));
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextField(
                    controller: _Discount,
                    decoration: InputDecoration(
                        icon: Icon(Icons.description), labelText: 'Discount')));
            SizedBox(
              height: 20,
            );
            Text("Balance = $balanceValue",
                style: TextStyle(
                  fontSize: 20,
                ));
            Divider(color: Colors.black);
            SizedBox(
              height: 20,
            );
            ButtonBar(
              children: [
                RaisedButton(
                  child: Text("Pay Now"),
                  textColor: Colors.white,
                  color: Colors.purple,
                  onPressed: () {
                    subTotal = double.parse(_SubTotal.text);
                    diliveryFee = double.parse(_DiliveryFee.text);
                    discountValue = double.parse(_Discount.text);

                    resultValue = ((subTotal + diliveryFee) - discountValue);

                    setState(() {
                      balanceValue = resultValue;
                    });

                    final ServiceProviderID = _ServiceProviderID.text;
                    final UserName = _UserName.text;
                    final Item = _Item.text;
                    final Quantity = _Quantity.text;
                    final ContactNumber = _ContactNumber.text;
                    final SubTotal = _SubTotal.text;
                    final DiliveryFee = _DiliveryFee.text;
                    final Discount = _Discount.text;
                    final Balance = resultValue.toString();
                    final Date = _date;

                    createUser(
                      ServiceProviderID: ServiceProviderID,
                      UserName: UserName,
                      Item: Item,
                      Quantity: Quantity,
                      ContactNumber: ContactNumber,
                      SubTotal: SubTotal,
                      DiliveryFee: DiliveryFee,
                      Discount: Discount,
                      Balance: Balance,
                      Date: Date,
                    );

                    print("the selected date is ${_date}");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => checkoutreceipt(
                              ServiceProviderID: _ServiceProviderID.text,
                              UserName: _UserName.text,
                              Item: _Item.text,
                              Quantity: _Quantity.text,
                              ContactNumber: _ContactNumber.text,
                              SubTotal: _SubTotal.text,
                              DiliveryFee: _DiliveryFee.text,
                              Discount: _Discount.text,
                              Balance: resultValue.toString(),
                              Date: _date,
                            )));
                  },
                ),
              ],
            );
          },
        )
      ])));

  Future createUser(
      {required String ServiceProviderID,
      UserName,
      Item,
      Quantity,
      ContactNumber,
      SubTotal,
      DiliveryFee,
      Discount,
      Balance,
      Date}) async {
    final docUser =
        FirebaseFirestore.instance.collection('orderpayments').doc();
    final json = {
      'serviceProviderID': ServiceProviderID,
      'userName': UserName,
      'Item': Item,
      'Quantity': Quantity,
      'ContactNumber': ContactNumber,
      'SubTotal': SubTotal,
      'DiliveryFee': DiliveryFee,
      'discount': Discount,
      'balance': Balance,
      'date': Date,
    };

    /// Create doc & write data to Firebase
    await docUser.set(json);
  }
}
*/