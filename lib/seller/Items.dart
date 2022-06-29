import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypart/buyer/productProvider.dart';
import 'package:mypart/buyer/productmoreinfo.dart';
import 'package:mypart/dashboard/dashboard.dart';
import 'package:mypart/firebaseservice.dart';
import 'package:mypart/seller/ItemProvider.dart';
import 'package:mypart/seller/ItemsMoreInfo.dart';
import 'package:mypart/seller/addItems.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsprousermodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import 'editItems.dart';



class Items extends StatefulWidget {
  
  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
   User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("vehicl parts providers")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  final _PriceFormat = NumberFormat('##,##,##0');
  
   
  @override
  Widget build(BuildContext context) {
    CollectionReference vehicleparts =
      FirebaseFirestore.instance.collection('vehicl parts providers/${loggedInUser.uid}/AutoParts');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => AddItems()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text('My Items'),
         leading: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Nav_side(title: 'Dashboard',)));
            },
            child: const Icon(
              Icons.arrow_back,
              size:30,
              color: Colors.white,
            ),
          ),
      ),
      body: Container(
        
       child: FutureBuilder<QuerySnapshot>(
          future:  vehicleparts.get(),
      
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        'My Items',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 210,
                      childAspectRatio: 2 / 2.1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int i) {
                      var data = snapshot.data!.docs[i];
                      var _price = int.parse(data['ItemPrice']);

                      String _FormatedPrice =
                          '\Rs. ${_PriceFormat.format(_price)}';

                      var _provider = Provider.of<ItemProvider>(context);

                      return InkWell(
                        onTap: () {
                          _provider.getItemDetails(data);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ItemsDetails()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8, left: 8, top: 8),
                                      child: Container(
                                        height: 85,
                                        child: Center(
                                          child: Image.network(data['Imageurl']),
                                        ),
                                      ),
                                    ),
                                    
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8, left: 8, top: 8),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(1),
                                          child: Column(
                                            children: [
                                              Text(
                                                data['ItemName'],
                                                style: TextStyle(fontSize: 12),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                _FormatedPrice,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                'Stock Qty: ' +
                                                    data['ItemQty'],
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        
                                       IconButton(
                                                  icon: Icon
                                                    (
                                                        Icons.edit,
                                                        color: Colors.purple,
                                                        
                                                    ),
                                                    onPressed: ()
                                                    {
                                                        Navigator.pushReplacement(
                                              context, MaterialPageRoute(builder: (_) => EditItem(docid: data,)));
                                                    }
                                                
                                              ),

                                              SizedBox(width: 20,),
                                               IconButton(
                                                  icon: Icon
                                                    (
                                                        Icons.delete,
                                                        color: Colors.purple,
                                                        
                                                    ),
                                                    onPressed: ()
                                                    {
                                                       data.reference.delete().whenComplete(() {
                                                      Navigator.pushReplacement(
                                                          context, MaterialPageRoute(builder: (_) => Items()));
                                                       }
                                                       );
                                                    }
                                                    
                                              )
                                      ],
                                    )
                                  ],
                                ),
                               
                              ],
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.purple.withOpacity(.8),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            );
        },
      ),
      ),
    );
  }

  

  
}
  

  