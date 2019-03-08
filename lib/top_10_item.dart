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
          if  (state.chartData != null) {
          if  (state.chartData.length > 0 ) {
            listWidgets=
                charts.PieChart(_createSampleData(state.chartData), defaultRenderer: new charts.ArcRendererConfig(
                    arcWidth: 60,
                    arcRendererDecorators: [new charts.ArcLabelDecorator()]));
          }

          }
          return Scaffold(
              appBar: AppBar(
                title: Text('Top 10 Item Sales'),
              ),
              body: SingleChildScrollView(

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: listWidgets,
                      color: Colors.white,
                      height: 350.0,
                      width: 300.0,
                    ),
                    Divider(),
                    Text('Item Details'),
                    TableList(channel: channel, rmsBloc: rmsBloc)
                  ],
                ),

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
        DataCell(Text(name["item"].toString())),
        DataCell(Text(name["sales"].toString()))
      ]));
    }

    return DataTable(columns: <DataColumn>[
      DataColumn(
        label: Text("Item Name"),
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