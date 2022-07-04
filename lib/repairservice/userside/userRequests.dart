
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mypart/orders/cancelledorders.dart';
import 'package:mypart/orders/updateacceptedorders.dart';
import 'package:mypart/repairservice/acceptservice.dart';
import 'package:mypart/repairservice/rejectRequest.dart';
import 'package:mypart/services/searchService.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsprousermodel.dart';

import '../../usermangment/usermodel.dart';


class VehicleOwnerNewRequest extends StatefulWidget {
  const VehicleOwnerNewRequest({Key? key}) : super(key: key);

  @override
  State<VehicleOwnerNewRequest> createState() => _VehicleOwnerNewRequestState();
}

class _VehicleOwnerNewRequestState extends State<VehicleOwnerNewRequest> {
   
  @override
  Widget build(BuildContext context) {
    final user= FirebaseAuth.instance.currentUser;
    CollectionReference orders =
      FirebaseFirestore.instance.collection('BookingDetails');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where('customerID', isEqualTo: user?.uid)
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

//////////////////////////////////////////////////////////////////////////
//processing Jobs
class ProcessingRepair extends StatefulWidget {
  const ProcessingRepair({Key? key}) : super(key: key);

  @override
  State<ProcessingRepair> createState() => _ProcessingRepairState();
}

class _ProcessingRepairState extends State<ProcessingRepair> {
  @override
  Widget build(BuildContext context) {
     final user= FirebaseAuth.instance.currentUser;
    CollectionReference orders =
      FirebaseFirestore.instance.collection('BookingDetails');
    return Scaffold(
         backgroundColor: const Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where('customerID', isEqualTo: user?.uid)
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

   



////////////////Finished Jobs
class FinishedService extends StatefulWidget {
  const FinishedService({Key? key}) : super(key: key);

  @override
  State<FinishedService> createState() => _FinishedServiceState();
}

class _FinishedServiceState extends State<FinishedService> {
    final user= FirebaseAuth.instance.currentUser;
    CollectionReference orders =
      FirebaseFirestore.instance.collection('BookingDetails');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 backgroundColor: const Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where('customerID', isEqualTo: user?.uid)
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


///////////cancelled Jobs

class CancelledRequest extends StatefulWidget {
  const CancelledRequest({Key? key}) : super(key: key);

  @override
  State<CancelledRequest> createState() => _CancelledRequestState();
}

class _CancelledRequestState extends State<CancelledRequest> {
   final user= FirebaseAuth.instance.currentUser;
    CollectionReference orders =
      FirebaseFirestore.instance.collection('BookingDetails');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
               .where('customerID', isEqualTo: user?.uid)
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