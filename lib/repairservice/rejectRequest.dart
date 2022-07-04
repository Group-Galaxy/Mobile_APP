
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mypart/orders/ordershome.dart';
import 'package:mypart/repairservice/myjobshome.dart';

class RejectRequests extends StatefulWidget {
  DocumentSnapshot docid;
 

  RejectRequests({required this.docid});


  @override
  State<RejectRequests> createState() => _RejectRequestsState();
}
class _RejectRequestsState extends State<RejectRequests> {
  
  List<String> _reason = <String>[
    'Busy at that time',
    'Cant reach to that location',
    'Not able to repair this vehicle type'
    
  ];
 var Selected_reason;
CollectionReference orders = FirebaseFirestore.instance.collection('Order Details');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      
     
      title: Text("Cancelled request"),
       
      
      ),
      body: Container(
       

        child:Column(
          children: [
                Padding(
                            padding: EdgeInsets.only(left: 10, right:10,bottom:8),
                            child: DropdownButtonFormField(
      
                                dropdownColor: Colors.white,
                                
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: _reason
                                    .map((value) => DropdownMenuItem(
                                          child: Text(
                                            value,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          value: value,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                 
                                  setState(() {
                                    Selected_reason = value;
                                  });
                                },
                                decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                     borderRadius: BorderRadius.circular(100.0),
                  ),
                                ),
                                value: Selected_reason,
                                isExpanded: false,
                                hint: Text(
                                  'Reason for cancel',
                                  style: TextStyle(color: Colors.black),
                                  
                                ),
                              ),
                          ),
                        
 ElevatedButton(
                onPressed: (){
                  widget.docid.reference.update({
                'Status':'cancelled',
                'resonForCancel':Selected_reason.toString(),
                 
                
              })
               
              .whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => MyJobs()));
              });
                },
                 child: Text('Conform'))

          ],

          
        )
        
              
             
           
            
          ),
         
        
      );
    
  }
}



 