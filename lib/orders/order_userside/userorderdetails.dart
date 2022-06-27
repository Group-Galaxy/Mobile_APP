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
                                             '2 min ago ',
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
}

class Todelivered extends StatelessWidget {
  const Todelivered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 170, 240),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) => Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                            children: const [
                              Text("CEAT 185/5",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(
                            width: 150,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "2 min ago",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: const [
                              Text("Quantity: 1",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 5.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'View More',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.purple,
                                        fixedSize: const Size(100, 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 150,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.close_outlined,
                                color: Colors.red,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Finished extends StatelessWidget {
  const Finished({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 170, 240),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) => Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                            children: const [
                              Text("CEAT 185/5",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(
                            width: 150,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "2 min ago",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: const [
                              Text("Quantity: 1",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 5.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'View More',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.purple,
                                        fixedSize: const Size(100, 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 150,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.close_outlined,
                                color: Colors.red,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Cancelled extends StatelessWidget {
  const Cancelled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 170, 240),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) => Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                            children: const [
                              Text("CEAT 185/5",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(
                            width: 150,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "2 min ago",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: const [
                              Text("Quantity: 1",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 5.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'View More',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.purple,
                                        fixedSize: const Size(100, 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 150,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.close_outlined,
                                color: Colors.red,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
