import 'package:flutter/material.dart';
import 'sales.dart';
import 'flutter_bloc/flutter_bloc.dart';
import 'monthly_sales.dart';
import 'yearly_sales.dart';
import 'channel/channel.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'top_10_item.dart';
import 'today_sales.dart';
import 'package:intl/intl.dart';
import 'rms.dart';

class MainSalesPage extends StatefulWidget {
  Channel channel;
  MainSalesPage({this.channel});

  MainSalesPageState createState() => MainSalesPageState();
}

class MainSalesPageState extends State<MainSalesPage> {
  Channel channel;
  var result;
  var result2;
  var result3;
  var result4;
  var result5;
  String date_start;
  String date_end;

  DateTime datetimestart;
  DateTime datetimeend;

  @override
  Widget build(BuildContext context) {
    channel = widget.channel;

    final RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);

    return BlocBuilder(
        bloc: rmsBloc,
        builder: (BuildContext context, RmsState state) {
          return Scaffold(
              appBar: AppBar(
                title: Icon(Icons.home),
                backgroundColor: Colors.orangeAccent,
              ),
              body: new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Text("Date: ${date_start} - ${date_end} ",
                        textAlign: TextAlign.center),
                    new MaterialButton(
                        color: Colors.deepOrangeAccent,
                        onPressed: () async {
                          final List<DateTime> picked =
                              await DateRagePicker.showDatePicker(
                                  context: context,
                                  initialFirstDate: new DateTime.now(),
                                  initialLastDate: (new DateTime.now())
                                      .add(new Duration(days: 7)),
                                  firstDate: new DateTime(2015),
                                  lastDate: new DateTime(2020));
                          if (picked != null && picked.length == 2) {
                            setState(() {
                              var formatter = new DateFormat('yyyy-MM-dd');
                              datetimestart = picked.first;
                              datetimeend = picked.last;
                              date_start = formatter.format(picked.first);
                              date_end = formatter.format(picked.last);

                              print(date_start);
                              print(date_end);
                            });
                          }
                        },
                        child: new Text("Pick date range")),
                    new RaisedButton(
                      child: Text('Daily Sales'),
                      onPressed: () async {
                        await channel.push("daily_sales",
                            {"date_start": date_start, "date_end": date_end});

                        channel.on("daily_sales_reply", (Map payload) {
                          result = payload["result"];

                          rmsBloc.dispatch(DailySales(result: result));
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SalesPage(channel: channel)),
                        );
                      },
                    ),
                    new RaisedButton(
                      child: Text('Monthly Sales'),
                      onPressed: () async {
                        await channel.push("monthly_sales",
                            {"date_start": date_start, "date_end": date_end});

                        channel.on("monthly_sales_reply", (Map payload) {
                          result2 = payload["result"];

                          rmsBloc.dispatch(MonthlySales(result: result2));
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MonthlySalesPage(channel: channel)),
                        );
                      },
                    ),
                    new RaisedButton(
                      child: Text('Yearly Sales'),
                      onPressed: () async {
                        await channel.push("yearly_sales",
                            {"date_start": date_start, "date_end": date_end});

                        channel.on("yearly_sales_reply", (Map payload) {
                          result3 = payload["result"];

                          rmsBloc.dispatch(YearlySales(result: result3));
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  YearlySalesPage(channel: channel)),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child:  new RaisedButton(
                          child: Text('Top 10 Item'),
                          onPressed: () async {
                            await channel.push("top_10_item",
                                {"date_start": date_start, "date_end": date_end});

                            channel.on("top_10_item_reply", (Map payload) {
                              result4 = payload["result"];

                              rmsBloc.dispatch(Top10SalesItem(result: result4));
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Top10SalesItemPage(channel: channel)),
                            );
                          },
                        ))
                     ,
                        Expanded(child: new RaisedButton(
                        child: Text('Today'),
                        onPressed: () async {

                          var formatter = new DateFormat('yyyy-MM-dd');
                          datetimestart = DateTime.now();
                          datetimeend = DateTime.now();

                          date_start = formatter.format(datetimestart);
                          date_end = formatter.format(datetimeend);

                          await channel.push("today_sales",
                              {"date_start": date_start, "date_end": date_end});

                          channel.on("today_sales_reply", (Map payload) {
                            result5 = payload["result"];

                            rmsBloc.dispatch(TodaySales(result: result5));
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TodaySalesPage(channel: channel)),
                          );
                        },
                      )),
                    ],)

                  ],
                ),
              ));
        });
  }
}
