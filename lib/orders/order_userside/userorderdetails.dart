import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypart/orders/order_userside/order_receipt.dart';
import 'package:mypart/orders/order_userside/viewmoreorders.dart';

import '../../usermangment/usermodel.dart';

class Neworders extends StatefulWidget {
  const Neworders({Key? key}) : super(key: key);

  @override
  State<Neworders> createState() => _NewordersState();
}

class _NewordersState extends State<Neworders> {
  @override
  Widget build(BuildContext context) {
    final orderdVehicleOwner = FirebaseAuth.instance.currentUser;
    CollectionReference orders =
        FirebaseFirestore.instance.collection('Order Details');

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where('vehicle Owner Id', isEqualTo: orderdVehicleOwner?.uid)
              .where('Oreder Status', isEqualTo: 'Pending')
              .orderBy('Order Date Time', descending: true)
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
                                              'Rs ${data['Total'].toString()}',
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
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {

                                                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewMoreOrders(
                              date: (data['Order Date Time']),
                              price: data['Item Price'],
                              providerName: data['Service Provider Name'],
                              qty:data['Item Qty'],
                              item: data['Item Name'],
                              service_provider_id: data['Service Provider Id'],
                              total_fee:data['Total'],
                              deliveryfee: data['DeliveryFee'],
                              Imageurl:data['Imageurl'],
                              contactNO: data['ContactNo'],
                              OrderStatus:data['Oreder Status'],
                           
                            
                              
                             
                            )));
                                              },
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

  getTime(Timestamp Time) {
    DateTime OrderDate = Time.toDate();

    if (DateTime.now().difference(OrderDate).inMinutes < 2) {
      return "a few seconds ago";
    } else if (DateTime.now().difference(OrderDate).inMinutes < 60) {
      return "${DateTime.now().difference(OrderDate).inMinutes} min ago";
    } else if (DateTime.now().difference(OrderDate).inMinutes < 1440) {
      return "${DateTime.now().difference(OrderDate).inHours} hours ago";
    } else if (DateTime.now().difference(OrderDate).inMinutes > 1440) {
      return "${DateTime.now().difference(OrderDate).inDays} days ago";
    }
  }
}

//...............................................................................................................

class ToPayOrders extends StatefulWidget {
  const ToPayOrders({Key? key}) : super(key: key);

  @override
  State<ToPayOrders> createState() => _ToPayOrdersState();
}

class _ToPayOrdersState extends State<ToPayOrders> {
  @override
  User? orderdVehicleOwner = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel CurrentUser = VehicleOwnerModel();
  final VehicleOwner = FirebaseAuth.instance.currentUser;
  CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where(
                'vehicle Owner Id',
                isEqualTo: orderdVehicleOwner?.uid,
              )
              .where('Oreder Status', isEqualTo: 'accepted')
              .orderBy('Order Date Time', descending: true)
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
                  print(data.data());
                  print(data.data());
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                // Row(
                                //   children: [
                                //     // Column(
                                //     //   children: [
                                //     //     Padding(
                                //     //       padding: const EdgeInsets.only(
                                //     //           right: 8, left: 8, top: 5),
                                //     //       child: Container(
                                //     //         height: 50,
                                //     //         width: 50,
                                //     //         child: Center(
                                //     //           child: Image.network(
                                //     //               data['Imageurl']),
                                //     //         ),
                                //     //       ),
                                //     //     ),
                                //     //   ],
                                //     // ),
                                //     // Column(
                                //     //   children: [
                                //     //     Row(
                                //     //       children: [
                                //     //         Text(
                                //     //           data['Item Name'],
                                //     //           style: TextStyle(
                                //     //               fontSize: 12,
                                //     //               fontWeight: FontWeight.bold),
                                //     //           maxLines: 1,
                                //     //           overflow: TextOverflow.ellipsis,
                                //     //         ),
                                //     //       ],
                                //     //     ),
                                //     //     Row(
                                //     //       children: [
                                //     //         Text(
                                //     //           'Quantity : ' + data['Item Qty'],
                                //     //           style: TextStyle(fontSize: 12),
                                //     //         ),
                                //     //       ],
                                //     //     ),
                                //     //     Row(
                                //     //       children: [
                                //     //         Text(
                                //     //           'Total Payble fee : 2000',
                                //     //           style: TextStyle(fontSize: 12),
                                //     //         ),
                                //     //       ],
                                //     //     ),
                                //     //   ],
                                //     // ),
                                //     // const SizedBox(
                                //     //   width: 50,
                                //     // ),
                                //     // Column(
                                //     //   children: [
                                //     //     Row(
                                //     //       children: [
                                //     //         Text(
                                //     //           getTime(data['Order Date Time']),
                                //     //           style: TextStyle(
                                //     //               fontSize: 12,
                                //     //               fontWeight: FontWeight.bold),
                                //     //           maxLines: 1,
                                //     //           overflow: TextOverflow.ellipsis,
                                //     //         )
                                //     //       ],
                                //     //     ),
                                //     //     Row(
                                //     //       crossAxisAlignment:
                                //     //           CrossAxisAlignment.start,
                                //     //       children: [
                                //     //         ElevatedButton(
                                //     //           onPressed: () {},
                                //     //           child: const Text(
                                //     //             'Pay',
                                //     //             style: TextStyle(fontSize: 10),
                                //     //           ),
                                //     //           style: ElevatedButton.styleFrom(
                                //     //               primary: Colors.purple,
                                //     //               fixedSize: const Size(100, 9),
                                //     //               shape: RoundedRectangleBorder(
                                //     //                   borderRadius:
                                //     //                       BorderRadius.circular(
                                //     //                           50))),
                                //     //         ),
                                //     //       ],
                                //     //     ),
                                //     //   ],
                                //     // ),
                                //   ],
                                // ),
                                Row(
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
                                    Container(
                                      width: 150,
                                      child: Column(
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
                                                'Rs ${data['Total'].toString()}',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
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
                                            )
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderReceipt(
                                                              date: DateTime
                                                                      .now()
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10),
                                                              price: data[
                                                                      'SubTotal']
                                                                  .toString(),
                                                              providerName: data[
                                                                  'Service Provider Name'],
                                                              qty: data[
                                                                  'Item Qty'],
                                                              item: data[
                                                                  'Item Name'],
                                                              service_provider_id:
                                                                  data[
                                                                      'Service Provider Id'],
                                                              docid: data,
                                                            )));
                                              },
                                              child: const Text(
                                                'Pay',
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

  getTime(Timestamp Time) {
    DateTime OrderDate = Time.toDate();

    if (DateTime.now().difference(OrderDate).inMinutes < 2) {
      return "a few seconds ago";
    } else if (DateTime.now().difference(OrderDate).inMinutes < 60) {
      return "${DateTime.now().difference(OrderDate).inMinutes} min ago";
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
  final VehicleOwner = FirebaseAuth.instance.currentUser;
  CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where(
                'vehicle Owner Id',
                isEqualTo: orderdVehicleOwner?.uid,
              )
              .where('Oreder Status', isEqualTo:'paid')
              .orderBy('Order Date Time', descending: true)
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
                        child: Row(
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
                                      child: Image.network(data['Imageurl']),
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
                                      'Rs ${data['Total'].toString()}',
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
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  BorderRadius.circular(50))),
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

  getTime(Timestamp Time) {
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
  const Finished({Key? key, required int initialPage}) : super(key: key);

  @override
  State<Finished> createState() => _FinishedState();
}

class _FinishedState extends State<Finished> {
  @override
  @override
  User? orderdVehicleOwner = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel CurrentUser = VehicleOwnerModel();
  final VehicleOwner = FirebaseAuth.instance.currentUser;
  CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where(
                'vehicle Owner Id',
                isEqualTo: orderdVehicleOwner?.uid,
              )
              .where('Oreder Status', isEqualTo: 'finished')
              .orderBy('Order Date Time', descending: true)
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
                        child: Row(
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
                                      child: Image.network(data['Imageurl']),
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
                                      'Rs ${data['Total'].toString()}',
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
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {

                                           Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewMoreOrders(
                              date: (data['Order Date Time']),
                              price: data['Item Price'],
                              providerName: data['Service Provider Name'],
                              qty:data['Item Qty'],
                              item: data['Item Name'],
                              service_provider_id: data['Service Provider Id'],
                              total_fee:data['Total'],
                              deliveryfee: data['DeliveryFee'],
                              Imageurl:data['Imageurl'],
                              contactNO: data['ContactNo'],
                              OrderStatus:data['Oreder Status'],
                           
                            
                              
                             
                            )));
                                      },
                                      child: const Text(
                                        'View More',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.purple,
                                          fixedSize: const Size(100, 9),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50))),
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

  getTime(Timestamp Time) {
    DateTime OrderDate = Time.toDate();

    if (DateTime.now().difference(OrderDate).inMinutes < 2) {
      return "a few seconds ago";
    } else if (DateTime.now().difference(OrderDate).inMinutes < 60) {
      return "${DateTime.now().difference(OrderDate).inHours} mins ago";
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
  final VehicleOwner = FirebaseAuth.instance.currentUser;
  CollectionReference orders =
      FirebaseFirestore.instance.collection('Order Details');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: orders
              .where(
                'vehicle Owner Id',
                isEqualTo: orderdVehicleOwner?.uid,
              )
              .where('Oreder Status', isEqualTo: 'cancelled')
              .orderBy('Order Date Time', descending: true)
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
                        child: Row(
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
                                      child: Image.network(data['Imageurl']),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 160,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        child: Text(
                                          data['Item Name'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        child: Text(
                                          'Quantity : ' + data['Item Qty'],
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                          'Reason for cancel: ' +
                                              data['resonForCancel'],
                                          softWrap: false,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 40,
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

  getTime(Timestamp Time) {
    DateTime OrderDate = Time.toDate();

    if (DateTime.now().difference(OrderDate).inMinutes < 2) {
      return "a few seconds ago";
    } else if (DateTime.now().difference(OrderDate).inMinutes < 60) {
      return "${DateTime.now().difference(OrderDate).inMinutes} mins ago";
    } else if (DateTime.now().difference(OrderDate).inMinutes < 1440) {
      return "${DateTime.now().difference(OrderDate).inHours} hours ago";
    } else if (DateTime.now().difference(OrderDate).inMinutes > 1440) {
      return "${DateTime.now().difference(OrderDate).inDays} days ago";
    }
  }
}
