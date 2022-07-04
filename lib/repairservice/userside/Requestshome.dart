import 'package:flutter/material.dart';
import 'package:mypart/dashboard/dashboard.dart';
import 'package:mypart/dashboard/repairserviceDashboard.dart';
import 'package:mypart/repairservice/myjobs.dart';
import 'package:mypart/repairservice/userside/userRequests.dart';
import 'package:mypart/usermangment/usermodel.dart';


class MyRequests extends StatefulWidget {
  const MyRequests({Key? key}) : super(key: key);

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Jobs"),
          leading: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const RepaiirDashboard(
                            title: 'Dashboard',
                          )));
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Center(
                child: Tab(text: "New\nRequests"),
              ),
              Center(
                child: Tab(text: "Processing Jobs"),
              ),
              Center(
                child: Tab(text: "Finished Jobs"),
              ),
              Center(
                child: Tab(text: "Cancelled Jobs"),
              ),
              
            ],
          ),
        ),
        body:  TabBarView(
          children: [
           VehicleOwnerNewRequest(),
           ProcessingRepair(),
           FinishedService(),
           CancelledRequest()
          ],
        ),
      ),
    );
  }
}

