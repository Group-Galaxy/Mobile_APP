import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypart/orders/ordershome.dart';
import 'package:mypart/seller/Items.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsProviderLogin.dart';
import 'package:mypart/usermangment/vehicle%20parts%20provider/partsprousermodel.dart';

class Nav_side extends StatefulWidget {
const Nav_side({Key? key, required String title}) : super(key: key);
@override
_Nav_sideState createState() => _Nav_sideState();
}
class _Nav_sideState extends State<Nav_side> {
 User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  
   void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("vehicl parts providers")
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
body: const Center(
child: Text(
'Dashboard details',
style: TextStyle(fontSize: 20.0),
)),
drawer: Drawer(
child: ListView(
padding: EdgeInsets.zero,
children: <Widget>[
 UserAccountsDrawerHeader(
accountName: Text("user default"),
accountEmail: Text("snmotors@gmail.com"),
currentAccountPicture: CircleAvatar(
backgroundColor: Colors.blueGrey,
child: Text(
"S",
style: TextStyle(fontSize: 40.0),
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
leading: Icon(Icons.notifications),
title: Text("Notifications"),
onTap: () {
Navigator.pop(context);
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
title: Text("My orders"),
onTap: () {
  Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) =>Myorders ()));

},
),
ListTile(
leading: Icon(Icons.auto_graph_sharp),
title: Text("My Items"),
onTap: () {
Navigator.pushReplacement(
  
                context, MaterialPageRoute(builder: (_) => Items()));
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
  
                context, MaterialPageRoute(builder: (_) =>PartsProviderLogin ()));
},
),
],
),
),
);
}
}