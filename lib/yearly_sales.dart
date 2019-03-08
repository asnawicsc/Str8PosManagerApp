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
          print("state : ${rmsBloc.currentState.chartData}");

          if  (rmsBloc.currentState.chartData != null) {
            if (rmsBloc.currentState.chartData.length > 0 ) {
              listWidgets = charts.BarChart(
                  _createSampleData(rmsBloc.currentState.chartData), animate: false);
            }
          }
          return Scaffold(
              appBar: AppBar(
                title: Text('Yearly Sales'),
              ),
              body: SingleChildScrollView(

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: listWidgets,
                      color: Colors.white,
                      height: 300.0,
                      width: 500.0,
                    ),
                    Divider(),
                    Text('Sales Details'),
                    TableList(channel: channel, rmsBloc: rmsBloc)
                  ],
                ),

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

class TableList extends StatefulWidget {
  var rmsBloc;

  Channel channel;
  TableList({this.rmsBloc, this.channel});

  TableListState createState() => TableListState();
}

class TableListState extends State<TableList> {
  @override
  Widget build(BuildContext context) {
    final RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);
    List<DataRow> dr = [];
    for (var name in widget.rmsBloc.currentState.chartData) {
      dr.add(DataRow(cells: <DataCell>[
        DataCell(Text(name["year"].toString())),
        DataCell(Text(name["sales"].toString()))
      ]));
    }

    return DataTable(columns: <DataColumn>[
      DataColumn(
        label: Text("Year"),
        numeric: false,
        tooltip: "To display first name",
      ),
      DataColumn(
        label: Text("Total Sales (RM)"),
        numeric: false,
        tooltip: "To display first name",
      )
    ], rows: dr);
  }
}
