import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypart/dashboard/dashboard.dart';
import 'package:mypart/firebaseservice.dart';
import 'package:mypart/seller/addItems.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsprousermodel.dart';


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
  
   FirebaseService _service = FirebaseService();
  @override
  Widget build(BuildContext context) {
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
          future:  _service.VehicleItems.where('Service Provider Id',isEqualTo:loggedInUser.uid).get(),
      
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
               itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int i) {
                      var data = snapshot.data!.docs[i];
                
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            EditItem(docid: snapshot.data!.docs[i]),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                            
                          ),
                          
                          title: Text(
                           
                            data['Item Name'],
                          
                            
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            'Quantity'+data['Item Qty'],
                          
                            
                            style: TextStyle(
                              fontSize: 16,
                          ),
                          ),
                           
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      ),
    );
  }

  

  
}
  