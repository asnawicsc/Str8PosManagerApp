/// Bar chart example
///
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'channel/channel.dart';
import 'flutter_bloc/flutter_bloc.dart';
import 'rms.dart';
import 'package:progress_indicators/progress_indicators.dart';

class TodaySalesPage extends StatefulWidget {
  Channel channel;
  TodaySalesPage({@required this.channel});

  TodaySalesPageState createState() => TodaySalesPageState();
}

class TodaySalesPageState extends State<TodaySalesPage> {
  Channel channel;
  Widget listWidgets ;
  var result;

  @override
  void initState() {
    super.initState();
    channel = widget.channel;

  }

  @override
  Widget build(BuildContext context) {
    RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);
    listWidgets=    JumpingDotsProgressIndicator(
      fontSize: 20.0,
    );
    return BlocBuilder(
        bloc: rmsBloc,
        builder: (BuildContext context, RmsState state) {
          print("state : ${state.chartData}");

          if  (state.chartData.length > 0 ) {
            listWidgets=
                charts.BarChart(_createSampleData(state.chartData));
          }
          return Scaffold(
              appBar: AppBar(
                title: Text('Today Sales'),
              ),
              body: Container(
                child: listWidgets,
              ));
        });
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData(
      List<dynamic> salesData) {
    List<OrdinalSales> data = [];

    for (var data2 in salesData) {
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
