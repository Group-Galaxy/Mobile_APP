import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class pp_Report extends StatefulWidget {
  var start;
  var end;

  pp_Report({
    Key? mykey,
    required this.start,
    required this.end,
  }) : super(key: mykey);

  @override
  State<pp_Report> createState() => _ReportState();
}

class _ReportState extends State<pp_Report> {
  User? currentAutoPartsProvider = FirebaseAuth.instance.currentUser;
  // VehicleOwnerModel CurrentServiceprovider = VehicleOwnerModel();
  CollectionReference orders =
      FirebaseFirestore.instance.collection('orderpayments');
  final user = FirebaseAuth.instance.currentUser;
  var currentUser = {};
  @override
  void initState() {
    super.initState();

    final data = FirebaseFirestore.instance
        .collection('vehicl parts providers')
        .where("uid", isEqualTo: user!.uid)
        .get()
        .then((res) {
      print(res.docs.first.data()['email']);
      print("uid " + user!.uid);
      setState(() {
        currentUser = res.docs.first.data();
      });
    });
    print(data);
  }

  Widget build(BuildContext context) {
    Future<List<Card>> getReport() async {
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('orderpayments');
      QuerySnapshot querySnapshot = await _collectionRef
          // ignore: unnecessary_brace_in_string_interps
          .where('serviceProviderID', isEqualTo: '${currentUser['uid']}')
          .where('date', isLessThan: '${widget.end}')
          //.where('date', isGreaterThan: '2022-06-30 16:53:48.054208')
          .where('date', isGreaterThan: '${widget.start}')
          .orderBy('date', descending: false)
          .get();
      List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      List<Card> card_data = [];
      if (allData != null) {
        for (int i = 0; i < allData.length; i++) {
          Map data = Map<String, dynamic>.from(allData[i]);
          print(data['date']);
          card_data.add(Card(
            margin: EdgeInsets.all(8),
            child: Column(children: [
              GFListTile(
                color: GFColors.WHITE,
                titleText: 'Date : ${data['date'].toString().substring(0, 10)}',
                subTitleText: 'Time : ${data['date'].toString().substring(
                      10,
                    )}',
              ),
              GFListTile(
                color: GFColors.WHITE,
              ),
              //Text('Date : ${data['date'].toString().substring(0, 10)}'),
              SizedBox(
                width: double.infinity,
              ),
              Text('Time : ${data['date'].toString().substring(
                    10,
                  )}'),
              SizedBox(
                width: double.infinity,
              ),
              Text(data['serviceProviderName'].toString()),
              SizedBox(
                width: double.infinity,
              ),
              Text(data['userName'].toString()),
              SizedBox(
                width: double.infinity,
              ),
              Text(data['vehicleFault'].toString()),
              SizedBox(
                width: double.infinity,
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
        title: Text('Parts Provider Report'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Card(
        child: SafeArea(
          child: SingleChildScrollView(
            // child: Column(children: [
            // GFListTile(
            //   color: GFColors.WHITE,
            //   titleText: 'Item : ${widget.item}',
            // ),
            // ]
            // )

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
      ),
    );
  }
}
