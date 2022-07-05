import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'sales_statical.dart';

class SalesChart extends StatelessWidget {
  final List<SalesStatical> data;

  SalesChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SalesStatical, String>> series = [
      charts.Series(
          id: "sales",
          data: data,
          domainFn: (SalesStatical series, _) => series.Week,
          measureFn: (SalesStatical series, _) => series.Sales,
          colorFn: (SalesStatical series, _) => series.barColor)
    ];

    return Container(
      
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Sales statical overview of Week",
                //style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
