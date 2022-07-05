import 'package:flutter/foundation.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SalesStatical {
  final String Week;
  final int Sales;
  final charts.Color barColor;

  SalesStatical(
      {required this.Week, required this.Sales, required this.barColor});
}
