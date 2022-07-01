import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypart/dashboard/components/card_custom.dart';
import 'package:mypart/dashboard/components/circle_progress.dart';
import 'package:mypart/dashboard/components/list_tile_custom.dart';
import 'package:mypart/dashboard/themes.dart';
import 'package:mypart/notifications/partsprovider_notifiacations.dart';
import 'package:mypart/orders/ordershome.dart';
import 'package:mypart/seller/Items.dart';
import 'package:mypart/usermangment/splashScreen.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsprousermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chat/chat_home.dart';

class NavSide extends StatefulWidget {
  const NavSide({Key? key, required String title}) : super(key: key);
  @override
  _NavSideState createState() => _NavSideState();
}

class _NavSideState extends State<NavSide> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    setAc();
    FirebaseFirestore.instance
        .collection("vehicl parts providers")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      notification();
      setState(() {});
    });
  }

  notification() async {
    final db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
        .collection('vehicl parts providers/${user?.uid}/Order')
        .snapshots();

    messageStream.forEach((element) {
      debugPrint(element.docs.length.toString());
      for (var element in element.docs) {
        debugPrint(element["Ordernew"].toString());
        if (element["Ordernew"]) {
          Fluttertoast.showToast(
              msg: "${element["Service Provider Name"]} has new order",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          final fs = FirebaseFirestore.instance;

          fs
              .collection('vehicl parts providers/${user?.uid}/Order')
              .doc(element.id)
              .set({
            "Ordernew": false,
          }, SetOptions(merge: true));
        }
      }
    });
  }

  setAc() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDriver', false);
    await prefs.setBool('ismechanic', false);
    await prefs.setBool('isparts', true);
  }

  @override
  Widget build(BuildContext context) {
    final fs = FirebaseFirestore.instance;
    final curr = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
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
                                    const Text("LKR 65000",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const Text(
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
                                        const Text("per week",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Text("NEW ACHIEVMENT",
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
                  padding: const EdgeInsets.all(20.0),
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
                            width: MediaQuery.of(context).size.width * .42,
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
                            width: MediaQuery.of(context).size.width * .42,
                            height: 88,
                            mLeft: 3,
                            mRight: 0,
                            child: ListTileCustom(
                              bgColor: greenLight,
                              pathIcon: "thumb_up.svg",
                              title: "Selling items",
                              subTitle: "654",
                            ),
                          ),
                        ],
                      ),
                      CardCustom(
                          mLeft: 0,
                          mRight: 0,
                          width: MediaQuery.of(context).size.width * .42,
                          height: 211,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: const [
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
                                    SizedBox(
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
              accountEmail: Text(loggedInUser.email ?? ""),
              currentAccountPicture:  CircleAvatar(
                
                 child: Image.network(loggedInUser.imgUrl ?? ""),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Dashboard"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text("Notifications"),
              onTap: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (_) => const PartsProviderNotifications()));
               },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text("Chat"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ChatHome(
                              sender: "vehicl parts providers",
                            )));
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop_outlined),
              title: const Text("My orders"),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const Myorders()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_graph_sharp),
              title: const Text("My Items"),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Items()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.comment_sharp),
              title: const Text("Comments & Ratings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_sharp),
              title: const Text("Log out"),
              onTap: () async {
                prefs.setBool('isDriver', false);
                prefs.setBool('ismechanic', false);
                prefs.setBool('isparts', false);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const MySplashScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
