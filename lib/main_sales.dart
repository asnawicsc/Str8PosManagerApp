import 'package:flutter/material.dart';
import 'sales.dart';
import 'flutter_bloc/flutter_bloc.dart';
import 'monthly_sales.dart';
import 'yearly_sales.dart';
import 'channel/channel.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'top_10_item.dart';
import 'today_sales.dart';
import 'this_month.dart';
import 'this_week.dart';
import 'this_year.dart';
import 'package:intl/intl.dart';
import 'rms.dart';
import 'package:progress_indicators/progress_indicators.dart';

class MainSalesPage extends StatefulWidget {
  Channel channel;
  MainSalesPage({this.channel});

  MainSalesPageState createState() => MainSalesPageState();
}

class MainSalesPageState extends State<MainSalesPage> {
  var result;
  var result2;
  var result3;
  var result4;
  var result5;
  var result6;
  Channel channel;
  Widget listWidgets;
  String date_start;
  String date_end;

  DateTime datetimestart;
  DateTime datetimeend;
  String dateStart;
  String dateEnd;
  String organization_code;
  String branch_name;
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    var channel = widget.channel;

    final RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);
    channel.on("organization_branch_reply", (Map payload) {
      List<String> branchStings = [];

      if (branchStings != null) {
        for (var i = 0; i < payload["result"].length; i++) {
          branchStings.add(payload["result"][i]);
        }
      } else {
       branchStings = [];
      }

//      rmsBloc.dispatch(OrganzationBranch(list: branchStings));
    });
    return BlocBuilder(
        bloc: rmsBloc,
        builder: (BuildContext context, RmsState state) {
          return Scaffold(
              appBar: AppBar(
                title: Icon(Icons.home),
                backgroundColor: Colors.orangeAccent,

                actions: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[



                  new Row(
                    children: <Widget>[
                      new Text("Date Range: ${date_start} - ${date_end} ",textAlign: TextAlign.start,),

                    ],
                  ),
                  new Row(
                    children: <Widget>[


                      new Text("Branch: ${state.currentBranchName}")

                    ],
                  )

                    ],
                  )





                ],
              ),
              body: new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: new RaisedButton(
                          child: Text('Sales'),
                          onPressed: () async {
                            var formatter = new DateFormat('yyyy-MM-dd');
                            datetimestart = DateTime.now();
                            datetimeend = DateTime.now();

                            dateStart = formatter.format(datetimestart);
                            dateEnd = formatter.format(datetimeend);

                            print("branch: ${state.currentBranchName}");

                            await channel.push("today_sales",
                                {"date_start": dateStart, "date_end": dateEnd,"organization_code": widget.channel.user,"branch_name": state.currentBranchName});

                            channel.on("today_sales_reply", (Map payload) {
                              result5 = payload["result"];

//                              rmsBloc.dispatch(TodaySales(
//                                  name: "This Day", result: result5));
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TodaySalesPage(channel: channel)),
                            );
                          },
                        )),
//                        Expanded(
//                            child: new RaisedButton(
//                          child: Text('This Week'),
//                          onPressed: () async {
//                            var formatter = new DateFormat('yyyy-MM-dd');
//                            datetimestart = DateTime.now();
//                            datetimeend = DateTime.now();
//
//                            dateStart = formatter.format(datetimestart);
//                            dateEnd = formatter.format(datetimeend);
//
//                            await channel.push("this_week_sales",
//                                {"date_start": dateStart, "date_end": dateEnd,"organization_code": widget.channel.user,"branch_name": state.currentBranchName});
//
//                            channel.on("this_week_sales_reply", (Map payload) {
//                              result3 = payload["result"];
//
//                              rmsBloc.dispatch(ThisWeekSales(
//                                  name: "This Week", result: result3));
//                            });
//
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) =>
//                                      ThisWeekSalesPage(channel: channel)),
//                            );
//                          },
//                        )),
//                        Expanded(
//                            child: new RaisedButton(
//                          child: Text('This Month'),
//                          onPressed: () async {
//                            var formatter = new DateFormat('yyyy-MM-dd');
//                            datetimestart = DateTime.now();
//                            datetimeend = DateTime.now();
//
//                            dateStart = formatter.format(datetimestart);
//                            dateEnd = formatter.format(datetimeend);
//
//                            await channel.push("this_month_sales",
//                                {"date_start": dateStart, "date_end": dateEnd,"organization_code": widget.channel.user,"branch_name": state.currentBranchName});
//
//                            channel.on("this_month_sales_reply", (Map payload) {
//                              result6 = payload["result"];
//
//                              rmsBloc.dispatch(ThisMonthSales(
//                                  name: "This Month", result: result6));
//                            });
//
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) =>
//                                      ThisMonthSalesPage(channel: channel)),
//                            );
//                          },
//                        )),
//                        Expanded(
//                            child: new RaisedButton(
//                          child: Text('This Year'),
//                          onPressed: () async {
//                            var formatter = new DateFormat('yyyy-MM-dd');
//                            datetimestart = DateTime.now();
//                            datetimeend = DateTime.now();
//
//                            dateStart = formatter.format(datetimestart);
//                            dateEnd = formatter.format(datetimeend);
//
//                            await channel.push("this_year_sales",
//                                {"date_start": dateStart, "date_end": dateEnd,"organization_code": widget.channel.user,"branch_name": state.currentBranchName});
//
//                            channel.on("this_year_sales_reply", (Map payload) {
//                              result3 = payload["result"];
//
//                              rmsBloc.dispatch(ThisYearSales(
//                                  name: "This Year", result: result3));
//                            });
//
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) =>
//                                      ThisYearSalesPage(channel: channel)),
//                            );
//                          },
//                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: new RaisedButton(
                          child: Text('Yesterday'),
                          onPressed: () async {
                            setState(() {
                              var formatter = new DateFormat('yyyy-MM-dd');

                              date_start = formatter.format(new DateTime.now()
                                  .subtract(new Duration(days: 1)));
                              date_end = formatter.format(new DateTime.now()
                                  .subtract(new Duration(days: 1)));

//                              rmsBloc.dispatch(DateRange(
//                                  result: [],
//                                  start_date: date_start,
//                                  end_date: date_end));
                            });
                          },
                        )),
                        Expanded(
                            child: new RaisedButton(
                          child: Text('Today'),
                          onPressed: () async {
                            setState(() {
                              var formatter = new DateFormat('yyyy-MM-dd');

                              date_start = formatter.format(new DateTime.now());
                              date_end = formatter.format(new DateTime.now());
//
//                              rmsBloc.dispatch(DateRange(
//                                  result: [],
//                                  start_date: date_start,
//                                  end_date: date_end));
                            });
                          },
                        )),
                        Expanded(
                            child: new RaisedButton(
                          child: Text('Last 7 Days'),
                          onPressed: () async {
                            setState(() {
                              var formatter = new DateFormat('yyyy-MM-dd');

                              date_start = formatter.format(new DateTime.now()
                                  .subtract(new Duration(days: 6)));
                              date_end = formatter.format(new DateTime.now());
//
//                              rmsBloc.dispatch(DateRange(
//                                  result: [],
//                                  start_date: date_start,
//                                  end_date: date_end));
                            });
                          },
                        )),
                        Expanded(
                            child: new RaisedButton(
                          child: Text('Last 30 Days'),
                          onPressed: () async {
                            setState(() {
                              var formatter = new DateFormat('yyyy-MM-dd');

                              date_start = formatter.format(new DateTime.now()
                                  .subtract(new Duration(days: 29)));
                              date_end = formatter.format(new DateTime.now());

//                              rmsBloc.dispatch(DateRange(
//                                  result: [],
//                                  start_date: date_start,
//                                  end_date: date_end));
                            });
                          },
                        )),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: const Card(),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: new MaterialButton(
                                color: Colors.deepOrangeAccent,
                                onPressed: () async {
                                  if (state.startDate == null) {
                                    setState(() {
                                      datetimestart = new DateTime.now();
                                    });
                                  } else {
                                    setState(() {
                                      datetimestart =
                                          DateTime.parse(state.startDate);
                                    });
                                  }

                                  if (state.endDate == null) {
                                    setState(() {
                                      datetimeend = new DateTime.now();
                                    });
                                  } else {
                                    setState(() {
                                      datetimeend =
                                          DateTime.parse(state.endDate);
                                    });
                                  }

                                  final List<DateTime> picked =
                                      await DateRagePicker.showDatePicker(
                                          context: context,
                                          initialFirstDate: datetimestart,
                                          initialLastDate: datetimeend,
                                          firstDate: new DateTime(2015),
                                          lastDate: new DateTime(2020));
                                  if (picked != null && picked.length == 2) {
                                    setState(() {
                                      var formatter =
                                          new DateFormat('yyyy-MM-dd');

                                      date_start =
                                          formatter.format(picked.first);
                                      date_end = formatter.format(picked.last);

//                                      rmsBloc.dispatch(DateRange(
//                                          result: [],
//                                          start_date: date_start,
//                                          end_date: date_end));
                                    });
                                  }
                                },
                                child: new Text("Pick date range"))),
                        BranchList(channel: channel, rmsBloc: rmsBloc)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: new RaisedButton(
                          child: Text('Daily Sales'),
                          onPressed: () async {
                            await channel.push("daily_sales", {
                              "date_start": date_start,
                              "date_end": date_end,"organization_code": widget.channel.user,"branch_name": state.currentBranchName
                            });

                            channel.on("daily_sales_reply", (Map payload) {
                              result = payload["result"];

//                              rmsBloc.dispatch(DailySales(result: result));
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SalesPage(channel: channel)),
                            );
                          },
                        )),
                        Expanded(
                            child: new RaisedButton(
                          child: Text('Monthly Sales'),
                          onPressed: () async {
                            await channel.push("monthly_sales", {
                              "date_start": date_start,
                              "date_end": date_end,"organization_code": widget.channel.user,"branch_name": state.currentBranchName
                            });

                            channel.on("monthly_sales_reply", (Map payload) {
                              result2 = payload["result"];

//                              rmsBloc.dispatch(MonthlySales(result: result2));
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MonthlySalesPage(channel: channel)),
                            );
                          },
                        )),
                        Expanded(
                            child: new RaisedButton(
                          child: Text('Yearly Sales'),
                          onPressed: () async {
                            await channel.push("yearly_sales", {
                              "date_start": date_start,
                              "date_end": date_end,"organization_code": widget.channel.user,"branch_name": state.currentBranchName
                            });

                            channel.on("yearly_sales_reply", (Map payload) {
                              result3 = payload["result"];

//                              rmsBloc.dispatch(YearlySales(result: result3));
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      YearlySalesPage(channel: channel)),
                            );
                          },
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: new RaisedButton(
                          child: Text('Top 10 Item'),
                          onPressed: () async {
                            await channel.push("top_10_item", {
                              "date_start": date_start,
                              "date_end": date_end,"organization_code": widget.channel.user,"branch_name": state.currentBranchName
                            });

                            channel.on("top_10_item_reply", (Map payload) {
                              result4 = payload["result"];

//                              rmsBloc.dispatch(Top10SalesItem(result: result4));
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Top10SalesItemPage(channel: channel)),
                            );
                          },
                        )),
                      ],
                    )
                  ],
                ),
              ));
        });
  }
}

class BranchList extends StatefulWidget {
  var rmsBloc;

  Channel channel;
  BranchList({this.rmsBloc, this.channel});

  BranchListState createState() => BranchListState();
}

class BranchListState extends State<BranchList> {
  List<dynamic> result_branch;
  List<String> branchStings = ['All Branch'];

  String dropdownValue;

  @override
  Widget build(BuildContext context) {

    final RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);
    branchStings = ['All Branch'];

    if (widget.rmsBloc.currentState.list != null) {
      for (var i = 0; i < widget.rmsBloc.currentState.list.length; i++) {
        branchStings.add(widget.rmsBloc.currentState.list[i]);
      }
    } else {
      branchStings = ['All Branch'];
    }



    return BlocBuilder(
        bloc: rmsBloc,
        builder: (BuildContext context, RmsState state) {
          return Expanded(

            child: DropdownButton<String>(
              hint: new Text("Select Branch",
                  textAlign: TextAlign.center),
              value: dropdownValue,
              onChanged: (String newValue) {
//                setState(() {
//                  dropdownValue = newValue;
//                  print(dropdownValue);
//                  rmsBloc.dispatch(BranchName(currentBranchName: dropdownValue));
//                });
              },
              style: new TextStyle(
                color: Colors.red,
                fontSize: 18.0,
              ),
              items: branchStings.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));

              }).toList(),
            ),

          );
        });
  }
}
