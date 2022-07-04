import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mypart/repairservice/myjobshome.dart';

class AcceptService extends StatefulWidget {
  DocumentSnapshot docid;
  AcceptService({required this.docid});

  @override
  State<AcceptService> createState() => _AcceptServiceState();
}

class _AcceptServiceState extends State<AcceptService> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
   appBar: AppBar(
      
     
      title: Text(""),
       
      
      ),
      body: Container(
       

        child:
          AlertDialog(
            content: Text('Do you want to accept the request'),
            actions: [
              FlatButton(
                onPressed: (){
                  widget.docid.reference.update({
                'Status':'accepted'
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => MyJobs()));
              });
                },
                 child: Text('Conform'))
            ],
            
          ),
         
        
      ),
    );

    
    
  }
}