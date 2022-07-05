import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypart/dashboard/components/card_custom.dart';
import 'package:mypart/dashboard/components/list_tile_custom.dart';
import 'package:mypart/dashboard/designs/sales_chart.dart';
import 'package:mypart/dashboard/designs/sales_statical.dart';
import 'package:mypart/dashboard/themes.dart';
import 'package:mypart/repairservice/myjobshome.dart';
import 'package:mypart/report/sp_report_dates.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsprousermodel.dart';
import 'package:mypart/usermangment/vehicle%20repair%20service%20provider/repairserviceproLogin.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class RepaiirDashboard extends StatefulWidget {
  const RepaiirDashboard({Key? key, required String title}) : super(key: key);
  @override
  _RepaiirDashboardState createState() => _RepaiirDashboardState();
}

class _RepaiirDashboardState extends State<RepaiirDashboard> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("vehicle repair service provider")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
 final List<SalesStatical> data = [
    SalesStatical(
      Week: "Mon",
      Sales: 12000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SalesStatical(
      Week: "Tues",
      Sales: 9000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SalesStatical(
      Week: "Wed",
      Sales: 25000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SalesStatical(
      Week: "Thurs",
      Sales: 8050,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SalesStatical(
      Week: "Fri",
      Sales: 30000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SalesStatical(
      Week: "Satur",
      Sales: 45600,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SalesStatical(
      Week: "Sun",
      Sales: 55000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
  ];
  
  get dateRange => null;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    DateTimeRange dateRange = DateTimeRange(
      start: DateTime(2022, 01, 01),
      end: DateTime(2022, 12, 31),
    );
    final start = dateRange.start;
    final end = dateRange.end;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body:  SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Center(
                          child: RichText(
                            text: TextSpan(
                                text: "Overveiw of",
                                style: GoogleFonts.montserrat().copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: purple1),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: " this week",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ]),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CardCustom(
                              mLeft: 0,
                              mRight: 3,
                              width: size.width / 2.5,
                              height: 88,
                              child: ListTileCustom(
                                bgColor: Color.fromARGB(255, 247, 219, 80),
                                pathIcon: "line.svg",
                                title: "New Requests",
                                subTitle: "30",
                              ),
                            ),
                            CardCustom(
                              width: size.width / 2.5,
                              height: 88,
                              mLeft: 3,
                              mRight: 0,
                              child: ListTileCustom(
                                bgColor: Colors.indigo,
                                pathIcon: "thumb_up.svg",
                                title: "Selling items",
                                subTitle: "654",
                              ),
                            ),
                          ],
                        ),
                        /*SizedBox(height: 20),
                        Text(
                          'Date Range',
                        ),
                        const SizedBox(height: 10),*/
                        /*Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  child: Text(
                                      '${start.year}/${start.month}/${start.day}'),
                                  onPressed: pickDateRange,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const SizedBox(width: 30),
                              Expanded(
                                child: ElevatedButton(
                                  child: Text(
                                      '${end.year}/${end.month}/${end.day}'),
                                  onPressed: pickDateRange,
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        Center(child: SalesChart(data: data)),
                      ],
                    ),
                  ),
                  //  ),
                ],
              ),
            ),
          ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(loggedInUser.firstName ?? ""),
              accountEmail: Text(loggedInUser.email ?? " "),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueGrey,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Dashboard"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Notifications"),
              onTap: () {
                /* Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) =>PartsProviderNotifications ()));*/
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text("Chat"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shop_outlined),
              title: Text("My jobs"),
              onTap: () {
                //receipts page....
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyJobs()
                        // Receipts(
                        //       booking_id: "QgletgMwmVmzk9mdATif",
                        //     )

                        ));
              },
            ),
            ListTile(
              leading: Icon(Icons.comment_sharp),
              title: Text("Comments & Ratings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.report),
              title: Text("Monthly Report"),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => sp_DateRange(
                              title: '',
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_sharp),
              title: Text("Log out"),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => RepairServiceProviderLogin()));
              },
            ),
          ],
        ),
      ),
    );
  }

  /*Future pickDateRange() async {
    DateTimeRange? newDataRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (newDataRange == null) return;

    setState(() => dateRange = newDataRange);*/
  }

