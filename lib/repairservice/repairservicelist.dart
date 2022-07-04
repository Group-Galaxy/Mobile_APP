import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypart/firebaseservice.dart';
import 'package:mypart/repairservice/Booking.dart';
import 'package:mypart/repairservice/repairProvider.dart';
import 'package:mypart/reviews/review_show_screen.dart';
import 'package:provider/provider.dart';



class RepairList extends StatefulWidget {
  const RepairList({Key? key}) : super(key: key);

  @override
  State<RepairList> createState() => _RepairListState();
}

class _RepairListState extends State<RepairList> 
{
  @override
  final CollectionReference RepairServiceProvider = FirebaseFirestore.instance.collection('vehicle repair service provider');
   final curr = FirebaseAuth.instance.currentUser;
 
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<RepairProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Service Providers"),
        leading: ElevatedButton(
          onPressed: () {},
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Color.fromARGB(255, 228, 225, 225),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
      ),
      body: Container(
          child: FutureBuilder<QuerySnapshot>(
              future: RepairServiceProvider.get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                borderRadius: BorderRadius.circular(0.5),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 55.0,
                                          height: 55.0,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.green,
                                          ),
                                        ),
                                        const SizedBox(width: 5.0),
                                        SizedBox(
                                          width: 150,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(data['firstName'],
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(data['location'],
                                                  style: const TextStyle(
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                         
                                        Container(
                                          
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 10.0),
                                          child: FlatButton(
                                            
                                               onPressed: () async {
                                              
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) => const ReviewShowScreen(
                                                          getter: "vehicle repair service provider",
                                                          sender: "VehicleOwner",
                                                          getterId: 'lnL9eiQ9dsRPlykqT4SDL03c63z2',

                                                          


                                                        ),
                                                      ));
                                                },
                                            
                                            color: const Color.fromARGB(
                                                255, 222, 130, 238),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: const Text(
                                              "More Info",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                       
                                        Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 10.0),
                                          child: FlatButton(
                                            onPressed: () {

                                               _provider.getProductDetails(data);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Booking(title: 'Booking Details',)));
                                            },
                                            color: const Color.fromARGB(
                                                255, 222, 130, 238),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: const Text(
                                              "Book",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }),
                );
              })),
    );
  }
}
