/// Bar chart example
///
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'channel/channel.dart';
import 'flutter_bloc/flutter_bloc.dart';
import 'rms.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'this_month.dart';
import 'this_week.dart';
import 'this_year.dart';
import 'package:intl/intl.dart';
import 'main_sales.dart';

class TodaySalesPage extends StatefulWidget {
  Channel channel;
  TodaySalesPage({@required this.channel});

  TodaySalesPageState createState() => TodaySalesPageState();
}

class TodaySalesPageState extends State<TodaySalesPage> {
  Channel channel;
  Widget listWidgets;
  var result;

  var result2;
  var result3;
  var result4;
  var result5;
  var result6;

  String date_start;
  String date_end;

  DateTime datetimestart;
  DateTime datetimeend;
  String dateStart;
  String dateEnd;

  @override
  void initState() {
    super.initState();
    channel = widget.channel;
  }

  Choice _selectedChoice = choices[0]; // The app's "state".

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);
    listWidgets = JumpingDotsProgressIndicator(
      fontSize: 20.0,
    );

    switch (_selectedChoice.title) {
      case "Today":
        {
          var formatter = new DateFormat('yyyy-MM-dd');
          datetimestart = DateTime.now();
          datetimeend = DateTime.now();

          dateStart = formatter.format(datetimestart);
          dateEnd = formatter.format(datetimeend);

           channel.push("today_sales", {
            "date_start": dateStart,
            "date_end": dateEnd,
            "organization_code": widget.channel.user,
            "branch_name": rmsBloc.currentState.currentBranchName
          });

          channel.on("today_sales_reply", (Map payload) {
            result5 = payload["result"];

            rmsBloc.dispatch(
                TodaySales(name: "This Day", result: result5));
          });

        }
        break;

      case "Week":
        {
          var formatter = new DateFormat('yyyy-MM-dd');
          datetimestart = DateTime.now();
          datetimeend = DateTime.now();

          dateStart = formatter.format(datetimestart);
          dateEnd = formatter.format(datetimeend);

           channel.push("this_week_sales", {
            "date_start": dateStart,
            "date_end": dateEnd,
            "organization_code": widget.channel.user,
            "branch_name": rmsBloc.currentState.currentBranchName
          });

          channel.on("this_week_sales_reply", (Map payload) {
            result3 = payload["result"];

            rmsBloc.dispatch(
                ThisWeekSales(name: "This Week", result: result3));
          });



        }
        break;

      case "Month":
        {
          var formatter = new DateFormat('yyyy-MM-dd');
          datetimestart = DateTime.now();
          datetimeend = DateTime.now();

          dateStart = formatter.format(datetimestart);
          dateEnd = formatter.format(datetimeend);

           channel.push("this_month_sales", {
            "date_start": dateStart,
            "date_end": dateEnd,
            "organization_code": widget.channel.user,
            "branch_name": rmsBloc.currentState.currentBranchName
          });

          channel.on("this_month_sales_reply", (Map payload) {
            result6 = payload["result"];

            rmsBloc.dispatch(ThisMonthSales(
                name: "This Month", result: result6));
          });


        }
        break;

      case "Year":
        {
          var formatter = new DateFormat('yyyy-MM-dd');
          datetimestart = DateTime.now();
          datetimeend = DateTime.now();

          dateStart = formatter.format(datetimestart);
          dateEnd = formatter.format(datetimeend);

           channel.push("this_year_sales", {
            "date_start": dateStart,
            "date_end": dateEnd,
            "organization_code": widget.channel.user,
            "branch_name": rmsBloc.currentState.currentBranchName
          });

          channel.on("this_year_sales_reply", (Map payload) {
            result3 = payload["result"];

            rmsBloc.dispatch(ThisYearSales(
                name: "This Year", result: result3));
          });


        }
        break;

      default:
        {
          var formatter = new DateFormat('yyyy-MM-dd');
          datetimestart = DateTime.now();
          datetimeend = DateTime.now();

          dateStart = formatter.format(datetimestart);
          dateEnd = formatter.format(datetimeend);

          channel.push("today_sales", {
            "date_start": dateStart,
            "date_end": dateEnd,
            "organization_code": widget.channel.user,
            "branch_name": rmsBloc.currentState.currentBranchName
          });

          channel.on("today_sales_reply", (Map payload) {
            result5 = payload["result"];

            rmsBloc.dispatch(
                TodaySales(name: "This Day", result: result5));
          });
        }
        break;
    }

    return BlocBuilder(
        bloc: rmsBloc,
        builder: (BuildContext context, RmsState state) {
          if (state.chartData != null) {
            if (state.chartData.length > 0) {
              listWidgets = charts.BarChart(_createSampleData(state.chartData),
                  animate: false);
            }
          }

          return Scaffold(
              appBar: AppBar(
                title: Text("${rmsBloc.currentState.name}"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MainSalesPage(channel: channel)),
                      );
                    },
                  ),
                  PopupMenuButton<Choice>(
                    onSelected: _select,
                    itemBuilder: (BuildContext context) {
                      return choices.map((Choice choice) {
                        return PopupMenuItem<Choice>(
                          value: choice,
                          child: Text(choice.title),
                        );
                      }).toList();
                    },
                  ),
                ],
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
                    Container(
                      color: Colors.white,
                      height: 120.0,
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
        DataCell(Text(name["day"].toString())),
        DataCell(Text(name["sales"].toString()))
      ]));
    }

    return DataTable(columns: <DataColumn>[
      DataColumn(
        label: Text("Date"),
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

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Today', icon: Icons.directions_car),
  const Choice(title: 'Week', icon: Icons.directions_bike),
  const Choice(title: 'Month', icon: Icons.directions_boat),
  const Choice(title: 'Year', icon: Icons.directions_bus),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    print(choice.title);
    final TextStyle textStyle = Theme.of(context).textTheme.display2;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
