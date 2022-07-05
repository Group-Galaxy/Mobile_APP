//import './bar-model.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'bar_model.dart';

class BarChart extends StatelessWidget {
  const BarChart({Key? key}) : super(key: key);

  static List<charts.Series<BarModel, String>> _createSampleData() {
    final data = [
      BarModel("2016", 20),
      BarModel("2017", 23),
      BarModel("2018", 29),
      BarModel("2019", 30),
      BarModel("2020", 29),
      BarModel("2021", 23),
      BarModel("2022", 20),
    ];
    return [
      charts.Series<BarModel, String>(
        data: data,
        id: 'sales',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        domainFn: (BarModel barModeel, _) => barModeel.year,
        measureFn: (BarModel barModeel, _) => barModeel.value,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bar Chart"),
      ),
      body: Center(
        child: Container(
          height: 300,
          child: charts.BarChart(
            _createSampleData(),
            animate: true,
          ),
        ),
      ),
    );
  }
}
