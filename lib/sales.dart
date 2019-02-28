/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SalesPage extends StatelessWidget {

  List<dynamic> salesData;
  SalesPage({@required this.salesData});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Daily Sales'),
        ),
        body: Container(
          child:  charts.BarChart(_createSampleData(salesData)),
        ));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData(List<dynamic> salesData) {


    print(salesData);
    List<OrdinalSales> data = [];

    for (var data2 in salesData) {
      print(data2["day"]);
      print("sales val ${data2["sales"]}");
      data.add(     new OrdinalSales(data2["day"], data2["sales"] == 0 ? 0.00: data2["sales"]),);
    }



    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.day.toString(),
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final int day;
  final double sales;

  OrdinalSales(this.day, this.sales);
}
