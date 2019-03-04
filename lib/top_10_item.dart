/// Bar chart example
///
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'channel/channel.dart';
import 'flutter_bloc/flutter_bloc.dart';
import 'rms.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Top10SalesItemPage extends StatefulWidget {
  Channel channel;
  Top10SalesItemPage({@required this.channel});

  Top10SalesItemPageState createState() => Top10SalesItemPageState();
}

class Top10SalesItemPageState extends State<Top10SalesItemPage> {
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
                charts.PieChart(_createSampleData(state.chartData), defaultRenderer: new charts.ArcRendererConfig(
                    arcWidth: 60,
                    arcRendererDecorators: [new charts.ArcLabelDecorator()]));
          }
          return Scaffold(
              appBar: AppBar(
                title: Text('Daily Sales'),
              ),
              body: Container(
                child: listWidgets,
              ));
        });
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales2, String>> _createSampleData(
      List<dynamic> salesData) {
    List<LinearSales2> data = [];

    for (var data2 in salesData) {
      print(data2["item"]);
      print("sales val ${data2["sales"]}");

      try {
        data.add(     new LinearSales2(data2["item"], double.parse(data2["sales"]) ),);
      } catch(e1) {
        print(e1);
      }


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
