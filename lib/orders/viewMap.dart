import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mypart/orders/ordershome.dart';

class ViewMap extends StatefulWidget {
  DocumentSnapshot docid;
  
  ViewMap({required this.docid});


  @override
  State<ViewMap> createState() => _ViewMapState();
}
class _ViewMapState extends State<ViewMap> {
  
  
CollectionReference orders = FirebaseFirestore.instance.collection('Order Details');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      
     
      title: Text("view on map "),
       
      
      ),
      body: Container(
       

        child:Column(
          children: [
               
 ElevatedButton(
                onPressed: (){
                  widget.docid.reference.update({
                'Oreder Status':'finished',
               
                 
                
              })
               
              .whenComplete(() {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return Myorders(initialPage: 4,);
            }));
              });
                },
                 child: Text('Delivered'))

          ],

          
        )
        
              
             
           
            
          ),
         
        
      );
    
  }
}



 