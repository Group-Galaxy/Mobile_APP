import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    Future<List<Card>> getReport() async {
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('payments');
      QuerySnapshot querySnapshot = await _collectionRef.get();
      List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      List<Card> card_data = [];
      if (allData != null) {
        for (int i = 0; i < allData.length; i++) {
          Map data = Map<String, dynamic>.from(allData[i]);
          print(data['date']);
          card_data.add(Card(
            margin: EdgeInsets.all(8),
            child: Row(children: [
              Text(data['date'].toString()),
              SizedBox(
                width: 10,
              ),
              Text(data['serviceProviderName'].toString()),
              SizedBox(
                width: 10,
              ),
              Text(data['userName'].toString()),
              SizedBox(
                width: 10,
              ),
              Text(data['vehicleFault'].toString()),
              SizedBox(
                width: 10,
              ),
              Text(data['balance'].toString()),
            ]),
          ));
        }
      }
      return card_data;
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 213, 249),
      appBar: AppBar(
        title: Text('Report'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getReport(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator.adaptive();
              } else {
                final data = snapshot.data as List<Card>;
                return Column(
                  children: data,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
