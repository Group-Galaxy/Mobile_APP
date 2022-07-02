
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mypart/orders/ordershome.dart';

class RejectOrder extends StatefulWidget {
  DocumentSnapshot docid;
  final String Item_Name,Qty;

  RejectOrder({required this.Item_Name,required this.Qty,required this.docid});


  @override
  State<RejectOrder> createState() => _RejectOrderState();
}
class _RejectOrderState extends State<RejectOrder> {
  
  List<String> _reason = <String>[
    'Enough Quantiy',
    'Items already selles',
    'Other',
    
  ];
 var Selected_preason;
CollectionReference orders = FirebaseFirestore.instance.collection('Order Details');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      
     
      title: Text("Cancelled Orders"),
       
      
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
                                    Selected_preason = value;
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
                                value: Selected_preason,
                                isExpanded: false,
                                hint: Text(
                                  'Reason for delete',
                                  style: TextStyle(color: Colors.black),
                                  
                                ),
                              ),
                          ),
                        
 ElevatedButton(
                onPressed: (){
                  widget.docid.reference.update({
                'Oreder Status':'cancelled',
                'resonForCancel':Selected_preason.toString(),
                 
                
              })
               
              .whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Myorders()));
              });
                },
                 child: Text('Conform'))

          ],

          
        )
        
              
             
           
            
          ),
         
        
      );
    
  }
}



 