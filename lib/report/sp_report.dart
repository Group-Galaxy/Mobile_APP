import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';

class sp_Report extends StatefulWidget {
  var start;
  var end;

  sp_Report({
    Key? mykey,
    required this.start,
    required this.end,
  }) : super(key: mykey);

  @override
  State<sp_Report> createState() => _ReportStateSP();
}

class _ReportStateSP extends State<sp_Report> {
  User? currentAutoPartsProvider = FirebaseAuth.instance.currentUser;
  // VehicleOwnerModel CurrentServiceprovider = VehicleOwnerModel();
  CollectionReference orders =
      FirebaseFirestore.instance.collection('payments');
  final user = FirebaseAuth.instance.currentUser;
  var currentUser = {};
  @override
  void initState() {
    super.initState();

    final data = FirebaseFirestore.instance
        .collection('vehicle repair service provider')
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
    var total = 0.0;
    Future<List<Card>> getReport() async {
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('payments');
      QuerySnapshot querySnapshot = await _collectionRef
          //.where('serviceProviderID', isEqualTo: '${currentUser['uid']}')
          .where('date', isLessThan: '2022-12-02 16:53:48.054208')
          .where('date', isGreaterThan: '2022-01-30 16:53:48.054208')
          .orderBy('date', descending: false)
          .get();
      List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      List<Card> card_data = [];
      if (allData != null) {
        for (int i = 0; i < allData.length; i++) {
          Map data = Map<String, dynamic>.from(allData[i]);
          total += double.parse(data['balance']);
          print(data['date']);

          card_data.add(Card(
            margin: EdgeInsets.all(8),
            child: Column(children: [
              GFListTile(
                color: GFColors.WHITE,
                titleText: 'Vehicle Fault : ${data['vehicleFault'].toString()}',
              ),
              Text('Date : ${data['date'].toString().substring(0, 10)}'),
              Text('Time : ${data['date'].toString().substring(
                    10,
                  )}'),

              Text('User Name : ${data['userName'].toString()}'),
              Text('Discount : ${data['discount'].toString()}'),
              Text('Balance : ${data['balance'].toString()}'),
              //Text(data['serviceProviderName'].toString()),
              // Text(data['vehicleFault'].toString()),

              // GFButton(
              //   onPressed: () {},
              //   text: "Rating",
              //   blockButton: true,
              // ),
              // GFButton(
              //   onPressed: () {},
              //   text: "Comment",
              //   blockButton: true,
              // ),
              // SizedBox(
              //   width: double.infinity,
              // ),
            ]),
          ));
        }
      }
      return card_data;
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 213, 249),
      appBar: AppBar(
        title: Text('Service Provider Report'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Card(
        child: SafeArea(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: getReport(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator.adaptive();
                } else {
                  final data = snapshot.data as List<Card>;
                  final total_card = Card(
                    child: Column(
                      children: [
                        GFAvatar(
                          backgroundColor: GFColors.TRANSPARENT,
                          child: ClipOval(
                            child: Image.network(
                              currentUser['imgUrl'],
                              fit: BoxFit.fill,
                            ),
                          ),
                          radius: 60,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('User Name : ${currentUser['firstName']}'),
                        Text("Total Earnings: ${total}"),
                        // Text("Total: ${total}"),
                      ],
                    ),
                    elevation: 8,
                    shadowColor: Colors.purple,
                    margin: EdgeInsets.all(15),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.purple, width: 2)),
                  );
                  data.insert(0, total_card);
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
