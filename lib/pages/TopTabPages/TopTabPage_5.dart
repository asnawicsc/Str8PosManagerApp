import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import '../../flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../rms.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../channel/channel.dart';
import 'package:progress_indicators/progress_indicators.dart';

class News5 extends StatefulWidget {
  News5({Key key, this.data, this.total4, this.total5,this.total6, this.channel, this.bloc})
      : super(key: key); //构造函数中增加参数
  final List<String> data;
  final List<dynamic> total4;
  final List<dynamic> total5;
  final List<dynamic> total6;
  final channel; //为参数分配空间
  RmsBloc bloc;

  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState();
}

//定义TAB页对象，这样做的好处就是，可以灵活定义每个tab页用到的对象，可结合Iterable对象使用，以后讲
class NewsTab {
  Channel channel;
  String text;
  NewsList newsList;

  NewsTab(this.text, this.newsList);
}

class _MyTabbedPageState extends State<News5> with TickerProviderStateMixin {
  Channel channel;
  List<String> data;
  List<dynamic> total4;
  List<dynamic> total5;
  List<dynamic> total6;

  String month_start;
  String month_end;
  String username;
  String password;
  Widget listWidgets;
  RmsBloc bloc;

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    var formatter = new DateFormat('MM');

    month_start = formatter.format(new DateTime.now());
    month_end = formatter.format(new DateTime.now());

    widget.bloc.dispatch(MonthRange(start_month: month_start, end_month: month_end));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<NewsTab> myTabs = <NewsTab>[];
    var channel = widget.channel;
    final RmsBloc rmsBloc = widget.bloc;



    List<String> branchStings = ["All Branch"];

    if (widget.bloc.currentState.list != null) {
      branchStings = widget.bloc.currentState.list;
    } else {
      branchStings = ["All Branch"];
    }

    _tabController =
    new TabController(vsync: this, length: branchStings.length);





    if (widget.data != []) {
      for (var data2 in widget.data) {
        myTabs.add(
          new NewsTab(
              data2,
              new NewsList(
                  newsType: data2,
                  total4: widget.total4,
                  total5: widget.total5,
                  total6: widget.total6,
                  date_start: month_start,
                  date_end: month_end,
                  rmsBloc: rmsBloc,
                  channel: channel)),
        );
      }
    } else {
      new NewsTab(
          "All Branch",
          new NewsList(
              newsType: "All Branch",
              total4: widget.total4,
              total5: widget.total5,
              total6: widget.total6,
              date_start: month_start,
              date_end: month_end,
              rmsBloc: rmsBloc,
              channel: channel));
    }

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.grey,
        title: new TabBar(
          controller: _tabController,
          tabs: myTabs.map((NewsTab item) {
            //NewsTab可以不用声明
            return new Tab(text: item.text);
          }).toList(),
          indicatorColor: Colors.white,
          isScrollable:
          true, //水平滚动的开关，开启后Tab标签可自适应宽度并可横向拉动，关闭后每个Tab自动压缩为总长符合屏幕宽度的等宽，默认关闭
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: myTabs.map((item) {
          return item.newsList; //使用参数值
        }).toList(),
      ),
    );
  }
}

//新闻列表
class NewsList extends StatefulWidget {
  final String newsType;
  String date_start;
  String date_end;
  String username;
  String password;
  RmsBloc rmsBloc;
  Channel channel;
  List total4;
  List total5;
  List total6;

  @override
  NewsList(
      {Key key,
        this.newsType,
        this.date_start,
        this.date_end,
        this.rmsBloc,
        this.channel,
        this.total4,
        this.total5,
        this.total6})
      : super(key: key);

  _NewsListState createState() => new _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List data;
  List total4;
  List total5;
  List total6;
  Channel channel;
  RmsBloc rmsBloc;
  String date_start;
  String date_end;
  String username;
  String password;
  Widget listWidgets;
  Widget listWidgets2;
  Widget listWidgets3;

  @override
  void initState() {
    super.initState();
    channel = widget.channel;
    listWidgets = JumpingDotsProgressIndicator(
      fontSize: 20.0,
    );
    listWidgets2 = JumpingDotsProgressIndicator(
      fontSize: 20.0,
    );

    listWidgets3 = JumpingDotsProgressIndicator(
      fontSize: 20.0,
    );

    widget.rmsBloc.dispatch(BranchName(
        currentBranchName: widget.newsType,
        start_month: widget.date_start,
        end_month: widget.date_end));
  }

  bool visibilityTag ;
  bool visibilityObs;

  @override
  Widget build(BuildContext context) {
    RmsBloc rmsBloc = widget.rmsBloc;


    setState(() {
      if (widget.rmsBloc.currentState.showTable == true){
        visibilityTag = true;
      }
      else
      { visibilityTag = false;}
      if (widget.rmsBloc.currentState.showGraph == true){
        visibilityObs = true;
      }else
      { visibilityObs = false;}
    });



    return BlocBuilder(
        bloc: rmsBloc,
        builder: (BuildContext context, RmsState state) {
//          print("username: ${state.username}");
//          print("password: ${state.password}");
//          print("start: ${state.startDate}");
//          print("end: ${state.endDate}");
//          print("branch: ${state.list}");
//          print("branch: ${state.currentBranchName}");
//          print("cd: ${state.chartData}");
//          print("cddd2: ${state.chartData2}");
//


//          channel.on("daily_sales_reply", (Map payload) {
//            print("dd: ${payload["result"]}");
//            rmsBloc.dispatch(DailySales(result: payload["result"],result2: payload["result2"]));

//        });




          if (widget.total4 != []) {
            if (widget.total4
                .where((t) => t["branch"] == widget.newsType)
                .isNotEmpty) {
              if (widget.total4
                  .where((t) => t["branch"] == widget.newsType)
                  .first !=
                  null) {
                if (widget.total4
                    .where((t) => t["branch"] == widget.newsType)
                    .first
                    .length >
                    0) {
                  listWidgets = charts.BarChart(
                      _createSampleData([
                        widget.total4
                            .where((t) => t["branch"] == widget.newsType)
                            .first
                      ]),
                      animate: false);
                }
              }
            }
          }




          if (widget.total5 != []) {
            if (widget.total5
                .where((t) => t["branch"] == widget.newsType)
                .isNotEmpty) {
              if (widget.total5.where((t) => t["branch"] == widget.newsType).toList() !=
                  null) {
                if (widget.total5
                    .where((t) => t["branch"] == widget.newsType)
                    .length >
                    0) {
                  listWidgets2 = charts.PieChart(
                      _createSampleData2(widget.total5.where((t) => t["branch"] == widget.newsType).toList()),
                      defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 60,
                          arcRendererDecorators: [new charts.ArcLabelDecorator()]));
                }
              }
            }

          } else
          { JumpingDotsProgressIndicator(
              fontSize: 20.0);}


          if (widget.total6 != []) {
            if (widget.total6
                .where((t) => t["branch"] == widget.newsType)
                .isNotEmpty) {
              if (widget.total6
                  .where((t) => t["branch"] == widget.newsType)
                  !=
                  null) {
                if (widget.total6
                    .where((t) => t["branch"] == widget.newsType)

                    .length >
                    0) {
                  listWidgets3 = charts.BarChart(
                      _createSampleData3(
                          widget.total6
                              .where((t) => t["branch"] == widget.newsType).toList()

                      ),
                      animate: false);
                }
              }
            }
          }


          return new  Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    visibilityObs == true ? Container(
                      child: listWidgets,
                      color: Colors.white,
                      height: 300.0,
                      width: 500.0,
                    ) : new Container(),
                    Divider(),

                    Text('Sales Details'),

                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(

                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              visibilityTag == true ?TableList(
                                  channel: channel,
                                  rmsBloc: rmsBloc,
                                  total4: widget.total4,
                                  branch: widget.newsType) : new Container(),
                            ])),


                    Divider(),
                    visibilityObs == true ? Container(
                      child: listWidgets2,
                      color: Colors.white,
                      height: 350.0,
                      width: 300.0,
                    ): new Container(),
                    Divider(
                      color: Colors.black,
                      height: 50,
                    ),
                    Text('Top 10 Items'),
                    visibilityTag == true ? TableListTwo(channel: channel,
                        rmsBloc: rmsBloc,
                        total5: widget.total5,
                        branch: widget.newsType): new Container(),
                    Divider(),
                    visibilityObs == true ? Container(
                      child: listWidgets3,
                      color: Colors.white,
                      height: 300.0,
                      width: 500.0,
                    ) : new Container(),
                    Divider(),

                    Text('Sales Payment'),
                    visibilityTag == true ?TableListThree(
                        channel: channel,
                        rmsBloc: rmsBloc,
                        total6: widget.total6,
                        branch: widget.newsType) : new Container(),
                  ],
                ),
              ));

        });
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData(
      List<dynamic> salesData) {
    List<OrdinalSales> data = [];

    if (salesData != null) {
      for (var data2 in salesData) {
        data.add(
          new OrdinalSales(
              data2["month"], data2["sales"] == 0 ? 0.00 : data2["sales"]),
        );
      }
    }

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.day.toString(),
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales2, String>> _createSampleData2(
      List<dynamic> salesData2) {

    print("chart2${salesData2}");

    List<LinearSales2> data2 = [];
    if (salesData2 != []) {
      if (salesData2 != null) {
        for (var data3 in salesData2) {
          try {
            data2.add(
              new LinearSales2(data3["item"], data3["sales"]),
            );
          } catch (e1) {
            print("data${e1}");
          }
        }

        return [
          new charts.Series<LinearSales2, String>(
            id: 'Sales',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (LinearSales2 sales, _) => sales.item,
            measureFn: (LinearSales2 sales, _) => sales.sales,
            data: data2,
            labelAccessorFn: (LinearSales2 row, _) => '${row.item}: ${row.sales}',
          )
        ];


      }

    }
    else
    {

      return [
        new charts.Series<LinearSales2, String>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (LinearSales2 sales, _) => "no_item",
          measureFn: (LinearSales2 sales, _) => 0.0,
          data: data2,
          labelAccessorFn: (LinearSales2 row, _) => '${"no_item"}: ${0.0}',
        )
      ];

    }




  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales3, String>> _createSampleData3(
      List<dynamic> salesData) {
    List<OrdinalSales3> data = [];

    if (salesData != null) {
      for (var data2 in salesData) {
        data.add(
          new OrdinalSales3(
              data2["payment_type"], data2["sales"] == 0 ? 0.00 : data2["sales"]),
        );
      }
    }

    return [
      new charts.Series<OrdinalSales3, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales3 sales, _) => sales.payment_type,
        measureFn: (OrdinalSales3 sales, _) => sales.sales,
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


/// Sample ordinal data type.
class OrdinalSales3 {
  final String payment_type;
  final double sales;

  OrdinalSales3(this.payment_type, this.sales);
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
  List total4;
  String branch;
  TableList({this.rmsBloc, this.channel, this.total4, this.branch});

  TableListState createState() => TableListState();
}

class TableListState extends State<TableList> {
  @override
  Widget build(BuildContext context) {

    final RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);
    List<DataRow> dr = [];

    if (widget.total4 != []) {
      if (widget.total4.where((t) => t["branch"] == widget.branch).isNotEmpty) {
        if (widget.total4.where((t) => t["branch"] == widget.branch).first !=
            null) {
          if (widget.total4
              .where((t) => t["branch"] == widget.branch)
              .first
              .length >
              0) {
            List list = [
              widget.total4.where((t) => t["branch"] == widget.branch).first
            ];

            for (var name in list) {

              if (name["status"] == "Increase"){
                dr.add(DataRow(cells: <DataCell>[
                  DataCell(Text(name["month"].toString(), style: new TextStyle(fontSize: 8.0))),
                  DataCell(Text(name["sales"].toString(), style: new TextStyle(fontSize: 8.0))),
                  DataCell(Text(name["prev_sales"].toString(), style: new TextStyle(fontSize: 8.0))),
                  DataCell(Icon(Icons.arrow_drop_up,color: Colors.green,))])
                );}
              if(name["status"] == "Decrease"){
                dr.add(DataRow(cells: <DataCell>[
                  DataCell(Text(name["month"].toString(), style: new TextStyle(fontSize: 8.0))),
                  DataCell(Text(name["sales"].toString(), style: new TextStyle(fontSize: 8.0))),
                  DataCell(Text(name["prev_sales"].toString(), style: new TextStyle(fontSize: 8.0))),
                  DataCell(Icon(Icons.arrow_drop_down,color: Colors.red,))])
                );}
              if(name["status"] == "Same")
              {
                dr.add(DataRow(cells: <DataCell>[
                  DataCell(Text(name["month"].toString(), style: new TextStyle(fontSize: 8.0))),
                  DataCell(Text(name["sales"].toString(), style: new TextStyle(fontSize: 8.0))),
                  DataCell(Text(name["prev_sales"].toString(), style: new TextStyle(fontSize: 8.0))),
                  DataCell(Icon(Icons.linear_scale,color: Colors.blue,))])
                );}



            }
          }
        }
      }
    }


    return DataTable(columns: <DataColumn>[
      DataColumn(
        label: Text("Month", style: new TextStyle(fontSize: 8.0)),
        numeric: false,
        tooltip: "Month",
      ),
      DataColumn(
        label: Text("Total Sales (RM)", style: new TextStyle(fontSize: 8.0)),
        numeric: false,
        tooltip: "Total Sales (RM)",
      ),
      DataColumn(
        label: Text("Total Previous Month Sales (RM)", style: new TextStyle(fontSize: 8.0)),
        numeric: false,
        tooltip: "Total Previous Month Sales (RM)",
      ),
      DataColumn(
        label: Text("Status", style: new TextStyle(fontSize: 8.0)),
        numeric: false,
        tooltip: "Status",
      )
    ], rows: dr);
  }
}


class TableListTwo extends StatefulWidget {
  var rmsBloc;
  List total5;
  String branch;
  Channel channel;
  TableListTwo({this.rmsBloc, this.channel,this.total5,this.branch});

  TableListTwoState createState() => TableListTwoState();
}

class TableListTwoState extends State<TableListTwo> {
  @override
  Widget build(BuildContext context) {
    final RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);
    List<DataRow> dr2 = [];
    if (rmsBloc.currentState.chartData2 != null) {
      if (rmsBloc.currentState.chartData2.length > 0) {
        for (var name in rmsBloc.currentState.chartData2) {
          print("name${name}");

        }
      }
    }

    if (widget.total5 != []) {
      if (widget.total5
          .where((t) => t["branch"] == widget.branch)
          .isNotEmpty) {
        if (widget.total5.where((t) => t["branch"] == widget.branch).toList() !=
            null) {
          if (widget.total5
              .where((t) => t["branch"] == widget.branch)
              .length >
              0) {
            for (var name in widget.total5.where((t) => t["branch"] == widget.branch).toList()) {
              dr2.add(DataRow(cells: <DataCell>[
                DataCell(Text(name["item"].toString(), style: new TextStyle(fontSize: 8.0))),
                DataCell(Text(name["sales"].toString(), style: new TextStyle(fontSize: 8.0)))
              ]));
            }

          }
        }
      }
    }

    return DataTable(columns: <DataColumn>[
      DataColumn(
        label: Text("Item Name", style: new TextStyle(fontSize: 8.0)),
        numeric: false,
        tooltip: "To display first name",
      ),
      DataColumn(
        label: Text("Total Sales (RM)", style: new TextStyle(fontSize: 8.0)),
        numeric: false,
        tooltip: "To display first name",
      )
    ], rows: dr2);
  }
}

class TableListThree extends StatefulWidget {
  var rmsBloc;
  List total6;
  String branch;
  Channel channel;
  TableListThree({this.rmsBloc, this.channel,this.total6,this.branch});

  TableListThreeState createState() => TableListThreeState();
}


class TableListThreeState extends State<TableListThree> {
  @override
  Widget build(BuildContext context) {
    final RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);
    List<DataRow> dr2 = [];
    if (rmsBloc.currentState.chartData2 != null) {
      if (rmsBloc.currentState.chartData2.length > 0) {
        for (var name in rmsBloc.currentState.chartData2) {
          print("name${name}");

        }
      }
    }

    if (widget.total6 != []) {
      if (widget.total6
          .where((t) => t["branch"] == widget.branch)
          .isNotEmpty) {
        if (widget.total6.where((t) => t["branch"] == widget.branch).toList() !=
            null) {
          if (widget.total6
              .where((t) => t["branch"] == widget.branch)
              .length >
              0) {
            for (var name in widget.total6.where((t) => t["branch"] == widget.branch).toList()) {
              dr2.add(DataRow(cells: <DataCell>[
                DataCell(Text(name["payment_type"], style: new TextStyle(fontSize: 8.0))),
                DataCell(Text(name["sales"].toString(), style: new TextStyle(fontSize: 8.0)))
              ]));
            }

          }
        }
      }
    }

    return DataTable(columns: <DataColumn>[

      DataColumn(
        label: Text("Payment Name", style: new TextStyle(fontSize: 8.0)),
        numeric: false,
        tooltip: "To display first name",
      ),
      DataColumn(
        label: Text("Total Sales (RM)", style: new TextStyle(fontSize: 8.0)),
        numeric: false,
        tooltip: "To display first name",
      )
    ], rows: dr2);
  }
}
