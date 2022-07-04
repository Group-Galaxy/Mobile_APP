import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypart/dashboard/components/card_custom.dart';
import 'package:mypart/dashboard/components/circle_progress.dart';
import 'package:mypart/dashboard/components/list_tile_custom.dart';
import 'package:mypart/dashboard/themes.dart';
import 'package:mypart/notifications/partsprovider_notifiacations.dart';
import 'package:mypart/orders/ordershome.dart';
import 'package:mypart/repairservice/myjobshome.dart';
import 'package:mypart/seller/Items.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsProviderLogin.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsprousermodel.dart';
import 'package:mypart/usermangment/vehicle%20repair%20service%20provider/repairserviceproLogin.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.20,
                        child: Column(
                          children: [
                            CustomPaint(
                              foregroundPainter: CircleProgress(),
                              child: SizedBox(
                                width: 180,
                                height: 147,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("LKR 65000",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "Total earnings",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_upward_outlined,
                                          color: green,
                                          size: 14,
                                        ),
                                        Text("per week",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Text("NEW ACHIEVMENT",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            //Text(
                            // "Social Star",
                            // style: textBold3,
                            // ),
                          ],
                        ),
                      ),
                      /* Container(
                        width: size.width / 2 - 20,
                        height: 180,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              //  image: AssetImage("assets/bd.jpeg"))),
                      )*/
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 5,
                  color: sparatorColor,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "Overveiw of",
                            style: GoogleFonts.montserrat().copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: purple1),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: " this week",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          CardCustom(
                            width: MediaQuery.of(context).size.width / 2.23,
                            height: 88,
                            mLeft: 0,
                            mRight: 3,
                            child: ListTileCustom(
                              bgColor: green,
                              pathIcon: "line.svg",
                              title: "New Requests",
                              subTitle: "30",
                            ),
                          ),
                          CardCustom(
                            width: MediaQuery.of(context).size.width / 2.23,
                            height: 88,
                            mLeft: 3,
                            mRight: 0,
                            child: ListTileCustom(
                              bgColor: greenLight,
                              pathIcon: "thumb_up.svg",
                              title: "Finished Jobs",
                              subTitle: "654",
                            ),
                          ),
                        ],
                      ),
                      CardCustom(
                          mLeft: 0,
                          mRight: 0,
                          width: MediaQuery.of(context).size.width / 40,
                          height: 211,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    /* Container(
                                    width: 8,
                                    height: 9.71,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: blueLight
                                    ),
                                  ),*/
                                    //SizedBox(
                                    //  width: 5,
                                    //),
                                    // Text("Users",
                                    //  style: label,
                                    // ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      /*decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: green
                                    ),*/
                                    ),
                                    // SizedBox(
                                    //   width: 3,
                                    // ),
                                    //Text("Selling Items",
                                    // style: label,
                                    // ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
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
 Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) =>MyJobs ()));

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
leading: Icon(Icons.logout_sharp),
title: Text("Log out"),
onTap: () {
Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) =>RepairServiceProviderLogin ()));
},
),
],
),
),
);
}
