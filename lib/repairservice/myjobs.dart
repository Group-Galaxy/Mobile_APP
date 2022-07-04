
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mypart/orders/cancelledorders.dart';
import 'package:mypart/orders/updateacceptedorders.dart';
import 'package:mypart/services/searchService.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsprousermodel.dart';

import '../../usermangment/usermodel.dart';

class NewRequests extends StatefulWidget {
  const NewRequests({Key? key}) : super(key: key);

  @override
  State<NewRequests> createState() => _NewRequestsState();
}

class _NewRequestsState extends State<NewRequests> {
  
  

     bool isaccepted=false;
     bool isrejected=false;
 
  

  @override
  Widget build(BuildContext context) {
     final ServiceProvider= FirebaseAuth.instance.currentUser;
    CollectionReference orders =
      FirebaseFirestore.instance.collection('BookingDetails');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where('ServiceProviderID', isEqualTo: ServiceProvider?.uid)
              .where('Status', isEqualTo: 'Pending').orderBy('BookingDate', descending: true)
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
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                data['vehicleFault'],
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                       Column(
                                        children: [
                                          Row(
                                           
                                            children: [
                                              Text(getTime(data['BookingDate']),
                                               style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              
                                              )

                                              
                                            ],
                                          ),
                                          Row(
                                             
                                            children:<Widget> [
                                              ElevatedButton(
                                                onPressed: () {
                                                   
                                              // Navigator.pushReplacement(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (_) => AcceptOrder(
                                              //               docid: data,
                                              //             )));
                                            
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  
                                                    primary: Colors.green,
                                                    fixedSize: const Size(100, 9),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50))),
                                                child: const Text(
                                                  'Accept',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                              
                                          ),
                                           Row(
                                             
                                            children:<Widget> [
                                              ElevatedButton(
                                                onPressed: () {
                                                  //  Navigator.pushReplacement(
                                                  // context,
                                                  // MaterialPageRoute(
                                                  //     builder: (_) => RejectOrder(
                                                  //           docid: data, Item_Name: data['Item Name'], Qty:  data['Item Qty'], 
                                                  //         )));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.red,
                                                    fixedSize: const Size(100, 9),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50))),
                                                child: const Text(
                                                  'Reject',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                              
                                          ),
                                         Row(
                                            
                                              crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.purple,
                                                    fixedSize: const Size(100, 9),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50))),
                                                child: const Text(
                                                  'View More',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            
                                            ],
                                          ),
                                         
                                        ],
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



//To pay tab 

class ProcessingJobs extends StatefulWidget {
  

  @override
  State<FinishedJobs> createState() => _FinishedJobsState();
}

class _FinishedJobsState extends State<FinishedJobs> {
  @override
  

    
 
  
   
 

  @override
  Widget build(BuildContext context) {
     final ServiceProvider= FirebaseAuth.instance.currentUser;
    CollectionReference orders =
      FirebaseFirestore.instance.collection('BookingDetails');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where('ServiceProviderID', isEqualTo: ServiceProvider?.uid)
              .where('Status', isEqualTo: 'accepted').orderBy('BookingDate', descending: true)
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
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                data['vehicleFault'],
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                       Column(
                                        children: [
                                          Row(
                                           
                                            children: [
                                              Text(getTime(data['BookingDate']),
                                               style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              
                                              )

                                              
                                            ],
                                          ),
                                          Row(
                                             
                                            children:<Widget> [
                                              ElevatedButton(
                                                onPressed: () {
                                                   
                                              // Navigator.pushReplacement(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (_) => AcceptOrder(
                                              //               docid: data,
                                              //             )));
                                            
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  
                                                    primary: Colors.green,
                                                    fixedSize: const Size(100, 9),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50))),
                                                child: const Text(
                                                  'Accept',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                              
                                          ),
                                           Row(
                                             
                                            children:<Widget> [
                                              ElevatedButton(
                                                onPressed: () {
                                                  //  Navigator.pushReplacement(
                                                  // context,
                                                  // MaterialPageRoute(
                                                  //     builder: (_) => RejectOrder(
                                                  //           docid: data, Item_Name: data['Item Name'], Qty:  data['Item Qty'], 
                                                  //         )));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.red,
                                                    fixedSize: const Size(100, 9),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50))),
                                                child: const Text(
                                                  'Reject',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                              
                                          ),
                                         Row(
                                            
                                              crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.purple,
                                                    fixedSize: const Size(100, 9),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50))),
                                                child: const Text(
                                                  'View More',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            
                                            ],
                                          ),
                                         
                                        ],
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

class FinishedJobs extends StatefulWidget {
 
  @override
  State<FinishedJobs> createState() => _FinishedJobsState();
}

class _ProcessingJobsState extends State<FinishedJobs> {
  @override
  

    
 
  
   
 

  @override
  Widget build(BuildContext context) {
     final ServiceProvider= FirebaseAuth.instance.currentUser;
    CollectionReference orders =
      FirebaseFirestore.instance.collection('BookingDetails');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where('ServiceProviderID', isEqualTo: ServiceProvider?.uid)
              .where('Status', isEqualTo: 'finished').orderBy('BookingDate', descending: true)
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
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                data['vehicleFault'],
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                       Column(
                                        children: [
                                          Row(
                                           
                                            children: [
                                              Text(getTime(data['BookingDate']),
                                               style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              
                                              )

                                              
                                            ],
                                          ),
                                          Row(
                                             
                                            children:<Widget> [
                                              ElevatedButton(
                                                onPressed: () {
                                                   
                                              // Navigator.pushReplacement(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (_) => AcceptOrder(
                                              //               docid: data,
                                              //             )));
                                            
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  
                                                    primary: Colors.green,
                                                    fixedSize: const Size(100, 9),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50))),
                                                child: const Text(
                                                  'Accept',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                              
                                          ),
                                           Row(
                                             
                                            children:<Widget> [
                                              ElevatedButton(
                                                onPressed: () {
                                                  //  Navigator.pushReplacement(
                                                  // context,
                                                  // MaterialPageRoute(
                                                  //     builder: (_) => RejectOrder(
                                                  //           docid: data, Item_Name: data['Item Name'], Qty:  data['Item Qty'], 
                                                  //         )));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.red,
                                                    fixedSize: const Size(100, 9),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50))),
                                                child: const Text(
                                                  'Reject',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                              
                                          ),
                                         Row(
                                            
                                              crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.purple,
                                                    fixedSize: const Size(100, 9),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50))),
                                                child: const Text(
                                                  'View More',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            
                                            ],
                                          ),
                                         
                                        ],
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

class CancelledJobs extends StatefulWidget {
  

  @override
  _CancelledJobs createState() => _CancelledJobs();
}

class _CancelledJobs extends State<ProcessingJobs> {
  @override
  

    
 
  
   
 

  @override
  Widget build(BuildContext context) {
     final ServiceProvider= FirebaseAuth.instance.currentUser;
    CollectionReference orders =
      FirebaseFirestore.instance.collection('BookingDetails');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where('ServiceProviderID', isEqualTo: ServiceProvider?.uid)
              .where('Status', isEqualTo: 'cancelled').orderBy('BookingDate', descending: true)
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
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                data['vehicleFault'],
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                       Column(
                                        children: [
                                          Row(
                                           
                                            children: [
                                              Text(getTime(data['BookingDate']),
                                               style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              
                                              )

                                              
                                            ],
                                          ),
                                          Row(
                                             
                                            children:<Widget> [
                                              ElevatedButton(
                                                onPressed: () {
                                                   
                                              // Navigator.pushReplacement(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (_) => AcceptOrder(
                                              //               docid: data,
                                              //             )));
                                            
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  
                                                    primary: Colors.green,
                                                    fixedSize: const Size(100, 9),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50))),
                                                child: const Text(
                                                  'Accept',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                              
                                          ),
                                           Row(
                                             
                                            children:<Widget> [
                                              ElevatedButton(
                                                onPressed: () {
                                                  //  Navigator.pushReplacement(
                                                  // context,
                                                  // MaterialPageRoute(
                                                  //     builder: (_) => RejectOrder(
                                                  //           docid: data, Item_Name: data['Item Name'], Qty:  data['Item Qty'], 
                                                  //         )));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.red,
                                                    fixedSize: const Size(100, 9),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50))),
                                                child: const Text(
                                                  'Reject',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                              
                                          ),
                                         Row(
                                            
                                              crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.purple,
                                                    fixedSize: const Size(100, 9),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50))),
                                                child: const Text(
                                                  'View More',
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            
                                            ],
                                          ),
                                         
                                        ],
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