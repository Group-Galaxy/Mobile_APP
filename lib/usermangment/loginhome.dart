import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypart/buyer/vehicle_parts_home.dart';
import 'package:mypart/orders/order_userside/userordermain.dart';
import 'package:mypart/repairservice/repairhome.dart';
import 'package:mypart/repairservice/userside/Requestshome.dart';
import 'package:mypart/usermangment/login.dart';
import 'package:mypart/usermangment/splashScreen.dart';
import 'package:mypart/usermangment/usermodel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../reviews/review_give_screen.dart';
import '../reviews/review_show_screen.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  _DriverHomeState createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  var imgUrl = "";
  final user = FirebaseAuth.instance.currentUser;
  
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAc();
  }

  setAc() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDriver', true);
    await prefs.setBool('ismechanic', false);
    await prefs.setBool('isparts', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                 Navigator.push(
                      context, MaterialPageRoute(builder: (_) => RepairHomeScreen()));
                },
                child: Align(
                    child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.purple)),
                  child: const Icon(
                    Icons.car_repair,
                    color: Colors.purple,
                    size: 75,
                  ),
                )),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Repair vehicle'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => VehiclePartsHome()));
                },
                child: Align(
                    child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.purple)),
                  child: const Icon(
                    Icons.shopping_cart_checkout,
                    color: Colors.purple,
                    size: 75,
                  ),
                )),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Buy vehicle parts'),
              ),
              TextButton(
                onPressed: () {
                  prefs.setBool('isDriver', false);
                  prefs.setBool('ismechanic', false);
                  prefs.setBool('isparts', false);
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                          builder: (_) => const MySplashScreen()));
                },
                child: const Text("Log Out"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ReviewGiveScreen(
                                getter: "vehicl parts providers",
                                getterId: "pMwHN6sWTxYSSzKXlRe6bTmWUAZ2",
                              )));
                },
                child: const Text("Review put"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ReviewShowScreen(
                          getter: "vehicl parts providers",
                          sender: "VehicleOwner",
                          getterId: "pMwHN6sWTxYSSzKXlRe6bTmWUAZ2",
                        ),
                      ));
                },
                child: const Text("Review show"),
              ),
            ],
          ),
        ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? ""),
              accountEmail: Text(user?.email ?? " "),
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
              leading: Icon(Icons.home),
              title: Text("Dashboard"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.square_list),
              title: Text("Orders"),
              onTap: () {
              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Myorders()));

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
leading: Icon(Icons.request_page_outlined),
title: Text("Repair Service Details"),
onTap: () {
 Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) =>MyRequests()));

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
  
                context, MaterialPageRoute(builder: (_) =>LoginScreen ()));
},
),
],
),
),
    );
  }
}
