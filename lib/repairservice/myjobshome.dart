import 'package:flutter/material.dart';
import 'package:mypart/dashboard/dashboard.dart';
import 'package:mypart/dashboard/repairserviceDashboard.dart';
import 'package:mypart/repairservice/myjobs.dart';


class MyJobs extends StatefulWidget {
  const MyJobs({Key? key}) : super(key: key);

  @override
  State<MyJobs> createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
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
           NewRequests(),
           ProcessingJobs(),
           FinishedJobs(),
           CancelledJobs(),
          ],
        ),
      ),
    );
  }
}

