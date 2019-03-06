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
import 'today_sales.dart';
import 'package:intl/intl.dart';
import 'main_sales.dart';

class ThisYearSalesPage extends StatefulWidget {
  Channel channel;
  ThisYearSalesPage({@required this.channel});

  ThisYearSalesPageState createState() => ThisYearSalesPageState();
}

class ThisYearSalesPageState extends State<ThisYearSalesPage> {
  Channel channel;
  Widget listWidgets ;
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

  @override
  Widget build(BuildContext context) {
    RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);
    print("yearlysales");
    listWidgets=    JumpingDotsProgressIndicator(
      fontSize: 20.0,
    );
    return BlocBuilder(
        bloc: rmsBloc,
        builder: (BuildContext context, RmsState state) {

            print("current lenge ${state.chartData.length}");
          if  (state.chartData.length > 0 ) {
            print("this is ${state.chartData}");
            listWidgets=
                charts.BarChart(_createSampleData(state.chartData),  animate: false);
          }
          return Scaffold(
              appBar: AppBar(
                title: Text("${state.name}"),
                actions: <Widget>[

                  FlatButton(
                    textColor: Colors.white,
                    onPressed: () async {
                      var formatter = new DateFormat('yyyy-MM-dd');
                      datetimestart = DateTime.now();
                      datetimeend = DateTime.now();

                      dateStart = formatter.format(datetimestart);
                      dateEnd = formatter.format(datetimeend);

                      await channel.push("today_sales",
                          {"date_start": dateStart, "date_end": dateEnd});

                      channel.on("today_sales_reply", (Map payload) {
                        result5 = payload["result"];

                        rmsBloc.dispatch(TodaySales(name: "This Day",result: result5));
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TodaySalesPage(channel: channel)),
                      );
                      Navigator.pop(context);


                    },
                    child: Text("Today"),
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.orangeAccent)),
                  ),
                  FlatButton(
                    textColor: Colors.white,
                    onPressed: () async {
                      var formatter = new DateFormat('yyyy-MM-dd');
                      datetimestart = DateTime.now();
                      datetimeend = DateTime.now();

                      dateStart = formatter.format(datetimestart);
                      dateEnd = formatter.format(datetimeend);

                      await channel.push("this_week_sales",
                          {"date_start": dateStart, "date_end": dateEnd});

                      channel.on("this_week_sales_reply", (Map payload) {
                        result3 = payload["result"];

                        rmsBloc.dispatch(ThisWeekSales(name: "This Week",result: result3));
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ThisWeekSalesPage(channel: channel)),
                      );
                      Navigator.pop(context);


                    },
                    child: Text("Week"),
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.orangeAccent)),
                  ),
                  FlatButton(
                    textColor: Colors.white,
                    onPressed: () async {
                      var formatter = new DateFormat('yyyy-MM-dd');
                      datetimestart = DateTime.now();
                      datetimeend = DateTime.now();

                      dateStart = formatter.format(datetimestart);
                      dateEnd = formatter.format(datetimeend);

                      await channel.push("this_month_sales",
                          {"date_start": dateStart, "date_end": dateEnd});

                      channel.on("this_month_sales_reply", (Map payload) {
                        result6 = payload["result"];

                        rmsBloc.dispatch(ThisMonthSales(name: "This Month",result: result6));
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ThisMonthSalesPage(channel: channel)),
                      );
                      Navigator.pop(context);


                    },
                    child: Text("Month"),
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.orangeAccent)),
                  ),
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainSalesPage(channel: channel)),
                      );


                    },
                  ),
                ],
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
