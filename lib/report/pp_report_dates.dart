import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mypart/report/pp_report.dart';
import 'package:mypart/report/report.dart';

class pp_DateRange extends StatefulWidget {
  const pp_DateRange({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<pp_DateRange> createState() => _DateRangeState();
}

class _DateRangeState extends State<pp_DateRange> {
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
      print(res.docs.first.data()['firstName']);
      print("uid " + user!.uid);
      setState(() {
        currentUser = res.docs.first.data();
      });
    });
    print(data);
  }

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 01, 01),
    end: DateTime(2022, 12, 31),
  );

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var start = dateRange.start;
    var end = dateRange.end;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 213, 249),
      appBar: AppBar(
        title: Text('Generate Selective Report'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GFListTile(
              color: GFColors.WHITE,
              titleText: 'Service Provider Name : ${currentUser['firstName']}',
            ),
            SizedBox(height: 20),
            Text(
              'Date Range',
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text('${start.year}/${start.month}/${start.day}'),
                      onPressed: pickDateRange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(width: 30),
                  Expanded(
                    child: ElevatedButton(
                      child: Text('${end.year}/${end.month}/${end.day}'),
                      onPressed: pickDateRange,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.black),
            SizedBox(
              height: 20,
            ),
            ButtonBar(
              children: [
                RaisedButton(
                  child: Text("Generate"),
                  textColor: Colors.white,
                  color: Colors.purple,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                pp_Report(start: start, end: end)));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDataRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (newDataRange == null) return;

    setState(() => dateRange = newDataRange);
  }
}
