/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';


class Top10SalesItem extends StatelessWidget {

  List<dynamic> salesData;
  Top10SalesItem({@required this.salesData});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Top 10 Items'),
        ),
        body: Container(
          child:  charts.PieChart(_createSampleData(salesData), defaultRenderer: new charts.ArcRendererConfig(
              arcWidth: 60,
              arcRendererDecorators: [new charts.ArcLabelDecorator()])),
        ));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales2, String>> _createSampleData(List<dynamic> salesData) {


    List<LinearSales2> data = [];

    for (var data2 in salesData) {
      print(data2["item"]);
      print("sales val ${data2["sales"]}");
      data.add(     new LinearSales2(data2["item"], double.parse(data2["sales"]) ),);
    }

    return [
      new charts.Series<LinearSales2, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales2 sales, _) => sales.item,
        measureFn: (LinearSales2 sales, _) => sales.sales,
        data: data, labelAccessorFn: (LinearSales2 row, _) => '${row.item}: ${row.sales}',
      )
    ];
  }
}

/// Sample ordinal data type.
class LinearSales2 {
  final String item;
  final double sales;

  LinearSales2(this.item, this.sales);
}
