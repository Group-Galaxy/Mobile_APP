import 'Items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class EditItem extends StatefulWidget {
  DocumentSnapshot docid;
  EditItem({required this.docid});

  @override
  State<EditItem> createState() => _EditItemState();
}
class _EditItemState extends State<EditItem> {
  TextEditingController Item_Name = TextEditingController();
  TextEditingController Item_Price = TextEditingController();
  TextEditingController Item_Qty = TextEditingController();
  TextEditingController ItemFeatures=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
       leading: new IconButton(
    icon: new Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () {
      Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) => Items()));
    },
  ), 
     
      title: Text("Edit Item"),
       
        actions: [
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'Item Name': Item_Name.text,
                'Item Price': Item_Price.text,
                'Item Qty':Item_Qty.text,
                'Item Features':ItemFeatures.text,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Items()));
              });
            },
            child: Text("save"),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Items()));
              });
            },
            child: Text("delete"),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
                  padding: EdgeInsets.only(left: 10, right:10,bottom:5),
                  child: TextFormField(
                    controller: Item_Name,
                    validator:(value){
                      
  
                },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                     
                            ),
                    
                      labelText: 'Item Name',
                     
    
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize:16,
                         ),
                    ),
                    ),

                    
                ),
               
               Padding(
                  padding: EdgeInsets.only(left: 10, right:10,bottom:5),
                 child: TextFormField(
                      controller: Item_Price,
                        
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                     
                            ),
                        labelText: 'Item Price',
                        
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize:16,
                           ),
                      ),
                      ),
               ),
                
       
                 Padding(
                    padding: EdgeInsets.only(left: 10, right:10,bottom:8),
                   child: TextFormField(
                        controller: Item_Qty,
                        inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
               ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                     
                            ),
                          labelText: 'Item Qty',
                          
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize:16,
                             ),
                        ),
                        keyboardType: TextInputType.number,
                        ),
                 ),
                          

                      

                  Padding(
                  padding: EdgeInsets.only(left: 10, right:10,bottom:5),
                 child: TextFormField(
                      controller: ItemFeatures,
                        
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                     
                            ),
                        labelText: 'Item Features',
                        
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize:16,
                           ),
                      ),
                      ),
               ),
          ],
        ),
      ),
    );
  }
}
