import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypart/dashboard/components/card_custom.dart';
import 'package:mypart/dashboard/components/circle_progress.dart';
import 'package:mypart/dashboard/components/list_tile_custom.dart';
import 'package:mypart/dashboard/designs/sales_chart.dart';
import 'package:mypart/dashboard/designs/sales_statical.dart';
import 'package:mypart/dashboard/themes.dart';
import 'package:mypart/notifications/partsprovider_notifiacations.dart';
import 'package:mypart/orders/ordershome.dart';
import 'package:mypart/report/pp_report_dates.dart';
import 'package:mypart/seller/Items.dart';
import 'package:mypart/usermangment/splashScreen.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsprousermodel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;


import '../chat/chat_home.dart';

class NavSide extends StatefulWidget {
  const NavSide({Key? key, required String title}) : super(key: key);
  @override
  _NavSideState createState() => _NavSideState();
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
class _NavSideState extends State<NavSide> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late SharedPreferences prefs;
  var imgUrl = "";
  @override
  void initState() {
    super.initState();
    notification();
    setAc();
    FirebaseFirestore.instance
        .collection("vehicl parts providers")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());

      setState(() {});
    });
  }

  notification() async {
    final db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
        .collection('Order Details')
        .snapshots();

    // messageStream.forEach((element) {
    //   debugPrint(element.docs.length.toString());
    //   for (var element in element.docs) {
    //     debugPrint(element["Ordernew"].toString());
    //     if (element["Ordernew"]) {
    //       Fluttertoast.showToast(
    //           msg: "You have new order from ${element["Vehicle Owner Name"]} ",
    //           toastLength: Toast.LENGTH_LONG,
    //           gravity: ToastGravity.TOP,
    //           timeInSecForIosWeb: 1,
    //           backgroundColor: Colors.red,
    //           textColor: Colors.white,
    //           fontSize: 16.0);
    //       final fs = FirebaseFirestore.instance;

    //       // fs
    //       //     .collection('vehicl parts providers/${user?.uid}/Order')
    //       //     .doc(element.id)
    //       //     .set({
    //       //   "Ordernew": false,
    //       // }, SetOptions(merge: true));
    //     }
    //   }
    // });
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
              accountEmail: Text(loggedInUser.email ?? ""),
              currentAccountPicture: GestureDetector(
                onTap: () async {
                  final firebaseStorage = FirebaseStorage.instance;
                  final imagePicker = ImagePicker();
                  XFile? image;
                  //Check Permissions
                  await Permission.photos.request();

                  var permissionStatus = await Permission.photos.status;

                  if (permissionStatus.isGranted) {
                    //Select Image
                    image = await imagePicker.pickImage(
                        source: ImageSource.gallery);

                    if (image != null) {
                      var file = File(image.path);
                      print("*******************");
                      print(image.path);
                      var snapshot = await firebaseStorage
                          .ref()
                          .child('users/profileimg')
                          .putFile(file);

                      imgUrl = await snapshot.ref.getDownloadURL();
                      await user?.updatePhotoURL(imgUrl);
                      setState(() {});
                      print(imgUrl.toString());
                    } else {
                      print('No Image Path Received');
                    }
                  } else {
                    print(
                        'Permission not granted. Try Again with permission access');
                  }
                },
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.grey,
                  child: CachedNetworkImage(
                    height: 150,
                    width: 150,
                    fit: BoxFit.fill,
                    imageUrl: FirebaseAuth.instance.currentUser?.photoURL ?? "",
                    placeholder: (context, url) => const CircleAvatar(
                      radius: 30.0,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.account_circle_outlined),
                  ),
                ),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>  PartsProviderNotifications()));
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
                    MaterialPageRoute(builder: (_) => const Myorders(initialPage: 1,)));
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
              leading: Icon(Icons.report),
              title: Text("Monthly Report"),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => pp_DateRange(
                              title: '',
                            )));
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
