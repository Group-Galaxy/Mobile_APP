
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      this.CurrentServiceprovider = UserModel.fromMap(value.data());
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
                'Service Provider Id',
                isEqualTo: CurrentServiceprovider.uid,
              )
              .where('Oreder Status', isEqualTo: 'Pending')
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
                                         
                                          children: [
                                             Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children:  [
                                                IconButton(
                                                  icon: Icon
                                                    (
                                                        Icons.check_circle_outline_rounded,
                                                        color: isaccepted ? Colors.green : Colors.grey
                                                    ),
                                                    onPressed: ()
                                                    {
                                                        setState(() 
                                                        {
                                                            isaccepted = !isaccepted;
                                                        });
                                                    }
                                                
                                              )
                                                
                                              ],
                                              
                                            ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children:  [
                                                IconButton(
                                                  icon: Icon
                                                    (
                                                        Icons.close_outlined,
                                                        color: isrejected ? Colors.red : Colors.grey
                                                    ),
                                                    onPressed: ()
                                                    {
                                                        setState(() 
                                                        {
                                                            isrejected = !isrejected;
                                                        });
                                                    }
                                                
                                              )
                                                
                                              ],
                                              
                                            ),

                                            
                                          ],
                                        ),
                                        const SizedBox(
                                      height: 20,


                                      
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



//To pay tab 

class ToPayOrders extends StatefulWidget {
  const ToPayOrders({Key? key}) : super(key: key);

  @override
  State<ToPayOrders> createState() => _ToPayOrdersState();
}

class _ToPayOrdersState extends State<ToPayOrders> {
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
      this.CurrentServiceprovider = UserModel.fromMap(value.data());
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
                'Service Provider Id',
                isEqualTo: CurrentServiceprovider.uid,
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
      this.CurrentServiceprovider = UserModel.fromMap(value.data());
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
                'Service Provider Id',
                isEqualTo: CurrentServiceprovider.uid,
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
      this.CurrentServiceprovider = UserModel.fromMap(value.data());
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
                'Service Provider Id',
                isEqualTo: CurrentServiceprovider.uid,
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

//cancelled tab

class Cancelled extends StatefulWidget {
  const Cancelled({Key? key}) : super(key: key);

  @override
  State<Cancelled> createState() => _CancelledState();
}

class _CancelledState extends State<Cancelled> {
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
      this.CurrentServiceprovider = UserModel.fromMap(value.data());
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
                'Service Provider Id',
                isEqualTo: CurrentServiceprovider.uid,
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