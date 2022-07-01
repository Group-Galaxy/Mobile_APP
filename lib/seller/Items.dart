import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypart/buyer/productProvider.dart';
import 'package:mypart/buyer/productmoreinfo.dart';
import 'package:mypart/dashboard/dashboard.dart';
import 'package:mypart/firebaseservice.dart';
import 'package:mypart/seller/ItemProvider.dart';
import 'package:mypart/seller/ItemsMoreInfo.dart';
import 'package:mypart/seller/addItems.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsprousermodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'editItems.dart';

class Items extends StatefulWidget {
  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("vehicl parts providers")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  final _PriceFormat = NumberFormat('##,##,##0');

  @override
  Widget build(BuildContext context) {
   CollectionReference vehicleparts = FirebaseFirestore.instance.collection('VehicleParts');
       
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => AddItems()));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text('My Items'),
        leading: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const NavSide(
                          title: 'Dashboard',
                        )));
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: vehicleparts.where('Service Provider Id', isEqualTo: loggedInUser.uid).get(),
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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: const Text(
                      'My Items',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 210,
                      childAspectRatio: 2 / 2.1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int i) {
                      var data = snapshot.data!.docs[i];
                      var price = int.parse(data['Item Price']);

                      String FormatedPrice =
                          'Rs. ${_PriceFormat.format(price)}';

                      var provider = Provider.of<ItemProvider>(context);

                      return InkWell(
                        onTap: () {
                          provider.getItemDetails(data);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ItemsDetails()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.purple.withOpacity(.8),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8, left: 8, top: 8),
                                      child: SizedBox(
                                        height: 85,
                                        child: Center(
                                          child:
                                              Image.network(data['Imageurl']),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8, left: 8, top: 8),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(1),
                                          child: Column(
                                            children: [
                                              Text(
                                                data['Item Name'],
                                                style: const TextStyle(
                                                    fontSize: 12),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                FormatedPrice,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                'Stock Qty: ' + data['StockQty'],
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.purple,
                                            ),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => EditItem(
                                                            docid: data,
                                                          )));
                                            }),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.purple,
                                            ),
                                            onPressed: () {
                                              data.reference
                                                  .delete()
                                                  .whenComplete(() {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            Items()));
                                              });
                                            })
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}
