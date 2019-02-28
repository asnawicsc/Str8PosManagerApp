/// Simple pie chart with outside labels example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class MonthlySales extends StatelessWidget {
  List<dynamic> salesData;
  MonthlySales({@required this.salesData});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Monthly Sales'),
        ),
        body: Container(
          child:  charts.PieChart(_createSampleData(salesData)),
        ));


  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData(List<dynamic> salesData) {
    print(salesData);
    List<LinearSales> data = [];


    for (var data2 in salesData) {
      print(data2["month"]);
      print("sales val ${data2["sales"]}");
      data.add(     new LinearSales(data2["month"], data2["sales"] == 0 ? 0.00: data2["sales"]),);
    }


    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final double sales;

  LinearSales(this.year, this.sales);
}