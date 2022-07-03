
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mypart/orders/ordershome.dart';

class AcceptOrder extends StatefulWidget {
  DocumentSnapshot docid;
  AcceptOrder({required this.docid});

  @override
  State<AcceptOrder> createState() => _AcceptOrderState();
}
class _AcceptOrderState extends State<AcceptOrder> {
  TextEditingController Item_Name = TextEditingController();
  TextEditingController Item_Price = TextEditingController();
  TextEditingController Item_Qty = TextEditingController();
  TextEditingController ItemFeatures=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      
     
      title: Text(""),
       
      
      ),
      body: Container(
       

        child:
          AlertDialog(
            content: Text('Do you want to accept the order'),
            actions: [
              FlatButton(
                onPressed: (){
                  widget.docid.reference.update({
                'Oreder Status':'accepted'
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Myorders()));
              });
                },
                 child: Text('Conform'))
            ],
            
          ),
         
        
      ),
    );
  }
}
