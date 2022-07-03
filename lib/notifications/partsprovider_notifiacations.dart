import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class PartsProviderNotifications extends StatefulWidget {
  

  @override
  State<PartsProviderNotifications> createState() => _PartsProviderNotificationsState();
}

class _PartsProviderNotificationsState extends State<PartsProviderNotifications> {
  @override
  Widget build(BuildContext context) {
   final vehiclePartsProvider= FirebaseAuth.instance.currentUser;
    CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      backgroundColor: Color.fromARGB(255, 254, 253, 254),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where('Service Provider Id', isEqualTo: vehiclePartsProvider?.uid)
              .where('Oreder Status', isEqualTo: 'Pending').orderBy('Order Date Time', descending: true)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            

            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (BuildContext context, int i) {
                  var data = snapshot.data!.docs[i];
                
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                       
                       
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: 
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Column(
                                        children: [
                                          
                                          Row(
                                            children: [
                                              Text(
                                               ' You have new order',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                width: 110,
                                              ),
                                              Text(getTime(data['Order Date Time']),
                                               style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              
                                              )

                                              
                                         
                                              
                                            ],
                                            
                                          ),
                                          
                                          Row(
                                            children: [
                                              Text(
                                               '${data['Vehicle Owner Name']} Order ${data['Item Name']}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),

                                           
                                          
                                        ],
                                        
                                      ),
                                      const SizedBox(
                                        width: 80,
                                      ),
                                       
                                         
                                          
                                           
                                        
                                       
                                    ],
                                  ),
                                 
                            
                        
                      )
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
getTime( Timestamp Time) {
    
    
DateTime OrderDate = Time.toDate();
   
    
    


  if (DateTime.now().difference(OrderDate).inMinutes < 2) {
    return "a few seconds ago";
  } else if (DateTime.now().difference(OrderDate).inMinutes < 60) {
    return "${DateTime.now().difference(OrderDate).inHours} min ago";
  } else if (DateTime.now().difference(OrderDate).inMinutes < 1440) {
    return "${DateTime.now().difference(OrderDate).inHours} hours ago";
  } else if (DateTime.now().difference(OrderDate).inMinutes > 1440) {
    return "${DateTime.now().difference(OrderDate).inDays} days ago";
  }
}
}



  