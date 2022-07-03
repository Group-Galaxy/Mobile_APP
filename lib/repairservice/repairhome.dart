import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:mypart/repairservice/all_my_pending_payments.dart';
import 'package:mypart/repairservice/repairservicelist.dart';
import 'package:mypart/usermangment/loginhome.dart';
import 'package:mypart/usermangment/welcomeScreen.dart';

class RepairHomeScreen extends StatefulWidget {
  const RepairHomeScreen({Key? key}) : super(key: key);

  @override
  State<RepairHomeScreen> createState() => _RepairHomeScreenState();
}

class _RepairHomeScreenState extends State<RepairHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search a mechanic"),
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => DriverHome()));
            },
          ),
        ),
        body: Container(
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    fixedSize: const Size(120, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => RepairList()));
                },
                child: Text('Next'),
              ),
              GFButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => MyAllPendingPayments()));
                },
                color: GFColors.FOCUS,
                text: "Show Pending..",
              )
            ],
          ),
        ));
  }
}
