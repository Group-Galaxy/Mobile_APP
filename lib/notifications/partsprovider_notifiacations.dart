import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:mypart/notifications/Update.dart';
import 'package:mypart/orders/ordershome.dart';

class PartsProviderNotifications extends StatefulWidget {
  

  @override
  State<PartsProviderNotifications> createState() => _PartsProviderNotificationsState();
}

class _PartsProviderNotificationsState extends State<PartsProviderNotifications> {
   bool Seennotify =true;
  @override
  Widget build(BuildContext context) {
   final vehiclePartsProvider= FirebaseAuth.instance.currentUser;
    CollectionReference Notifications =
      FirebaseFirestore.instance.collection('Notifications');
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      backgroundColor: Color.fromARGB(255, 254, 253, 254),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: Notifications
              .where('receiverId', isEqualTo: vehiclePartsProvider?.uid)
             .orderBy('SendTime', descending: true)
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

                 
              return SizedBox(
                width: double.infinity,
        height: 70,
                child: Card(

                           
                            elevation: 6.0,
                            
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),

                              
                            ),
                            child: InkWell(
                              onTap: () async {
                                data['Seen']==true? Colors.pink :Colors.amber;
                                Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const Myorders(initialPage: 1,)));
                               
                                    },
                             
                                child: 
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          
                                              children: [
                                                
                                                Row(
                                                  children: [
                                                    Text(
                                                     data['messageTitle'],
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      width: 160,
                                                    ),
                                                    Text(getTime(data['SendTime']),
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
                                                     data['messageBody'],
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
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
                        
                      
                
              
                      
                }
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



  