import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../usermangment/usermodel.dart';
import '../dashboard/dashboard.dart';

class PartsProviderNotifications extends StatefulWidget {
  const PartsProviderNotifications({Key? key}) : super(key: key);

  @override
  State<PartsProviderNotifications> createState() =>
      _PartsProviderNotificationsState();
}

class _PartsProviderNotificationsState
    extends State<PartsProviderNotifications> {
  User? receivedmessageUser = FirebaseAuth.instance.currentUser;
  VehicleOwnerModel CurrentUser = VehicleOwnerModel();
  CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications/{}/');
  bool _pressed = false;
  int count = 1;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("vehicl parts providers")
        .doc(receivedmessageUser!.uid)
        .get()
        .then((value) {
      CurrentUser = VehicleOwnerModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const NavSide(
                          title: 'Dashboard',
                        )));
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 235, 231, 235),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: notifications
              .where(
                'receiver',
                isEqualTo: CurrentUser.uid,
              )
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
                    child: InkWell(
                      onTap: () {
                        count = count - 1;
                        setState(() {
                          _pressed = true;
                        });
                      },
                      child: Card(
                        color: _pressed ? Colors.white : Colors.grey,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                data['message'],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        'Amal fernando order Amaron Battery',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        getTime(data['DateTime']),
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
                            ],
                          ),
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
