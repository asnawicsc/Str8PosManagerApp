import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'channel/channel.dart';
import 'flutter_bloc/flutter_bloc.dart';
import 'rms.dart';
import 'package:progress_indicators/progress_indicators.dart';

class YearlySalesPage extends StatefulWidget {
  Channel channel;
  YearlySalesPage({@required this.channel});

  YearlySalesPageState createState() =>YearlySalesPageState();
}

class YearlySalesPageState extends State<YearlySalesPage> {
  Channel channel;
  Widget listWidgets ;
  var result;

  @override
  void initState() {
    super.initState();
    channel = widget.channel;
    listWidgets=    JumpingDotsProgressIndicator(
      fontSize: 20.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);

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
                title: Text('Yearly Sales'),
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


      try {
        data.add(
          new OrdinalSales(
              data2["year"], data2["sales"] == 0 ? 0.00 : data2["sales"]),
        );

      } catch(e1) {
        print(e1);
      }



    }

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year.toString(),
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final int year;
  final double sales;

  OrdinalSales(this.year, this.sales);
}
