/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'channel/channel.dart';

class SalesPage extends StatefulWidget {
  Channel channel;
  SalesPage({@required this.channel});

  SalesPageState createState() => SalesPageState();
}

class SalesPageState extends State<SalesPage> {
  Channel channel;

  var result;

  @override
  void initState() {
    super.initState();
    channel = widget.channel;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidgets = [];

    channel.on("daily_sales_reply", (Map payload)  {
      result = payload["result"];


        listWidgets.add(
          Container(
            child: charts.BarChart(_createSampleData(result)),
          ),
        );

    });
    // turn into widget
    //widget call stack
    //put

    return Scaffold(
        appBar: AppBar(
          title: Text('Daily Sales'),
        ),
        body: Container(child: Stack(children: listWidgets)));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData(
      List<dynamic> salesData) {
    print(salesData);
    List<OrdinalSales> data = [];

    for (var data2 in salesData) {
      print(data2["day"]);
      print("sales val ${data2["sales"]}");
      data.add(
        new OrdinalSales(
            data2["day"], data2["sales"] == 0 ? 0.00 : data2["sales"]),
      );
    }

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
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
