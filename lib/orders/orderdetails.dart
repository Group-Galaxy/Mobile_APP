
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

class Neworders extends StatefulWidget {
  const Neworders({Key? key}) : super(key: key);

  @override
  State<Neworders> createState() => _NewordersState();
}

class _NewordersState extends State<Neworders> {
  User? currentAutoPartsProvider = FirebaseAuth.instance.currentUser;
  UserModel CurrentServiceprovider = UserModel();
  

     bool isaccepted=false;
     bool isrejected=false;
 
  

  @override
  Widget build(BuildContext context) {
     final vehiclePartsProvider= FirebaseAuth.instance.currentUser;
    CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 235),
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
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8, left: 8, top: 5),
                                            child: SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: Center(
                                                child: Image.network(
                                                    data['Imageurl']),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                data['Item Name'],
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Quantity : ' + data['Item Qty'],
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              Text(
                                                'Total Payble fee : 2000',
                                                style: TextStyle(fontSize: 12),
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
                                             
                                            children:<Widget> [
                                              ElevatedButton(
                                                onPressed: () {
                                                   
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => AcceptOrder(
                                                            docid: data,
                                                          )));
                                            
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
                                                   Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => RejectOrder(
                                                            docid: data, Item_Name: data['Item Name'], Qty:  data['Item Qty'], 
                                                          )));
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

class ToPayOrders extends StatefulWidget {
  const ToPayOrders({Key? key}) : super(key: key);

  @override
  State<ToPayOrders> createState() => _ToPayOrdersState();
}

class _ToPayOrdersState extends State<ToPayOrders> {
  @override
  

    
 
  
   
 

  @override
  Widget build(BuildContext context) {
     final PartsProvider = FirebaseAuth.instance.currentUser;


  
        CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where('Service Provider Id', isEqualTo: PartsProvider?.uid)
              
              .where('Oreder Status', isEqualTo: 'accepted')
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8, left: 8, top: 5),
                                            child: SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: Center(
                                                child: Image.network(
                                                    data['Imageurl']),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                data['Item Name'],
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Quantity : ' + data['Item Qty'],
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              Text(
                                                'Total Payble fee : 2000',
                                                style: TextStyle(fontSize: 12),
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

class ToDeliver extends StatefulWidget {
  const ToDeliver({Key? key}) : super(key: key);

  @override
  State<ToDeliver> createState() => _ToDeliverState();
}

class _ToDeliverState extends State<ToDeliver> {
  @override
 @override
  User? currentAutoPartsProvider = FirebaseAuth.instance.currentUser;
  UserModel CurrentServiceprovider = UserModel();
  CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');

     bool isaccepted=false;
     bool isrejected=false;
 
  
   
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("vehicl parts providers")
        .doc(currentAutoPartsProvider!.uid)
        .get()
        .then((value) {
      CurrentServiceprovider = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where(
                'Service Provider Id',
                isEqualTo: CurrentServiceprovider.uid,
              )
              .where('Oreder Status', isEqualTo: 'paid')
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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8, left: 8, top: 5),
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Center(
                                              child: Image.network(
                                                  data['Imageurl']),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              data['Item Name'],
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Quantity : ' + data['Item Qty'],
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: const [
                                            Text(
                                              'Total Payble fee : 2000',
                                              style: TextStyle(fontSize: 12),
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
                               
                          
                      ),
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


class Finished extends StatefulWidget {
  const Finished({Key? key}) : super(key: key);

  @override
  State<Finished> createState() => _FinishedState();
}

class _FinishedState extends State<Finished> {
  @override
  @override
  User? currentAutoPartsProvider = FirebaseAuth.instance.currentUser;
  UserModel CurrentServiceprovider = UserModel();
  CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');

     bool isaccepted=false;
     bool isrejected=false;
 
  
   
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("vehicl parts providers")
        .doc(currentAutoPartsProvider!.uid)
        .get()
        .then((value) {
      CurrentServiceprovider = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where(
                'Service Provider Id',
                isEqualTo: CurrentServiceprovider.uid,
              )
              .where('Oreder Status', isEqualTo: 'accepted')
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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8, left: 8, top: 5),
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Center(
                                              child: Image.network(
                                                  data['Imageurl']),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              data['Item Name'],
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Quantity : ' + data['Item Qty'],
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: const [
                                            Text(
                                              'Total Payble fee : 2000',
                                              style: TextStyle(fontSize: 12),
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
                               
                          
                      ),
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

//cancelled tab

class Cancelled extends StatefulWidget {
  const Cancelled({Key? key}) : super(key: key);

  @override
  State<Cancelled> createState() => _CancelledState();
}

class _CancelledState extends State<Cancelled> {
  @override
  @override
  
  CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');

     bool isaccepted=false;
     bool isrejected=false;
 
  
 

  @override
  Widget build(BuildContext context) {
      final vehiclePartsProvider= FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          
          future: orders
              .where(
                'Service Provider Id',
                isEqualTo: vehiclePartsProvider?.uid,
              )
              .where('Oreder Status', isEqualTo: 'cancelled')
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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8, left: 8, top: 5),
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Center(
                                              child: Image.network(
                                                  data['Imageurl']),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              data['Item Name'],
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Quantity : ' + data['Item Qty'],
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children:  [
                                            Text(
                                              'Reason for cancel '+data['resonForCancel'],
                                              softWrap: false,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 12),
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
                                            Text(getTime(data['Order Date Time']),
                                             style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            
                                            )

                                            
                                          ],
                                        ),

                                      
                                       
                                      ],
                                    ),
                                  ],
                                ),
                               
                          
                      ),
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