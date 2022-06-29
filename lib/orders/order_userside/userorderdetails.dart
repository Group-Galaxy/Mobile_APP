
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../usermangment/usermodel.dart';

class Neworders extends StatefulWidget {
  const Neworders({Key? key}) : super(key: key);

  @override
  State<Neworders> createState() => _NewordersState();
}

class _NewordersState extends State<Neworders> {
  final orderdVehicleOwner = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel CurrentUser = VehicleOwnerModel();
  
      

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(orderdVehicleOwner!.uid)
        .get()
        .then((value) {
      this.CurrentUser = VehicleOwnerModel.fromMap(value.data());
      setState(() {});
    });
  }

    
  @override
  Widget build(BuildContext context) {
     CollectionReference orders =
      FirebaseFirestore.instance.collection('users/${CurrentUser.uid}/UserOrders');
      
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
         
            .where('Oreder Status', isEqualTo: 'Pending')
            .get(
             
            ),
            
            
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
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
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 5.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8, left: 8, top: 5),
                                          child: Container(
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
                                              style: TextStyle(
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
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
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
                                            
                                            Text(
                                             getTime(data['Order Date Time']),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                      height: 50,
                                    ),
                                        Row(
                                          
                                            crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: const Text(
                                                'View More',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.purple,
                                                  fixedSize: const Size(100, 9),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50))),
                                            ),
                                          
                                          ],
                                        ),
                                       
                                      ],
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


class ToPayOrders extends StatefulWidget {
  const ToPayOrders({Key? key}) : super(key: key);

  @override
  State<ToPayOrders> createState() => _ToPayOrdersState();
}

class _ToPayOrdersState extends State<ToPayOrders> {
  @override
 User? orderdVehicleOwner = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel CurrentUser = VehicleOwnerModel();
  CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(orderdVehicleOwner!.uid)
        .get()
        .then((value) {
      this.CurrentUser = VehicleOwnerModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where(
                'vehicle Owner Id',
                isEqualTo: CurrentUser.uid,
              )
              .where('Oreder Status', isEqualTo: 'accepted')
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
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
                                          child: Container(
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
                                              style: TextStyle(
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
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
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
                                             style: TextStyle(
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
                                              child: const Text(
                                                'View More',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.purple,
                                                  fixedSize: const Size(100, 9),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50))),
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

class ToDeliver extends StatefulWidget {
  const ToDeliver({Key? key}) : super(key: key);

  @override
  State<ToDeliver> createState() => _ToDeliverState();
}

class _ToDeliverState extends State<ToDeliver> {
  @override
 @override
  User? orderdVehicleOwner = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel CurrentUser = VehicleOwnerModel();
  CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(orderdVehicleOwner!.uid)
        .get()
        .then((value) {
      this.CurrentUser = VehicleOwnerModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where(
                'vehicle Owner Id',
                isEqualTo: CurrentUser.uid,
              )
              .where('Oreder Status', isEqualTo: 'paid')
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
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
                                          child: Container(
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
                                              style: TextStyle(
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
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
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
                                             style: TextStyle(
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
                                              child: const Text(
                                                'View More',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.purple,
                                                  fixedSize: const Size(100, 9),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50))),
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
 User? orderdVehicleOwner = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel CurrentUser = VehicleOwnerModel();
  CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(orderdVehicleOwner!.uid)
        .get()
        .then((value) {
      this.CurrentUser = VehicleOwnerModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where(
                'vehicle Owner Id',
                isEqualTo: CurrentUser.uid,
              )
              .where('Oreder Status', isEqualTo: 'finished')
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
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
                                          child: Container(
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
                                              style: TextStyle(
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
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
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
                                             style: TextStyle(
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
                                              child: const Text(
                                                'View More',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.purple,
                                                  fixedSize: const Size(100, 9),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50))),
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
 User? orderdVehicleOwner = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel CurrentUser = VehicleOwnerModel();
  CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(orderdVehicleOwner!.uid)
        .get()
        .then((value) {
      this.CurrentUser = VehicleOwnerModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where(
                'vehicle Owner Id',
                isEqualTo: CurrentUser.uid,
              )
              .where('Oreder Status', isEqualTo: 'cancelled')
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
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
                                          child: Container(
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
                                              style: TextStyle(
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
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
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
                                             style: TextStyle(
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
                                              child: const Text(
                                                'View More',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.purple,
                                                  fixedSize: const Size(100, 9),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50))),
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