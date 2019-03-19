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

class News extends StatefulWidget {
  const News({ Key key , this.data, this.channel}) : super(key: key); //构造函数中增加参数
  final  List<String>  data;
  final channel;//为参数分配空间

  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState();
}

//定义TAB页对象，这样做的好处就是，可以灵活定义每个tab页用到的对象，可结合Iterable对象使用，以后讲
class NewsTab {
  Channel channel;
  String text;
  NewsList newsList;
  NewsTab(this.text,this.newsList);



}

class _MyTabbedPageState extends State<News> with TickerProviderStateMixin {

  Channel channel;


  String date_start;
  String date_end;
  Widget listWidgets ;




  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: widget.data.length);

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    List <NewsTab>  myTabs= <NewsTab>[];
    var channel = widget.channel;
    final RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);
    var result;
    var result4;
    var result2;


    if (widget.data != []) {
      for (var data2 in widget.data) {

        myTabs.add(
          new NewsTab(data2,new NewsList(newsType: data2,date_start: date_start,date_end: date_end,rmsBloc: rmsBloc,channel: channel )),
        );
      }
    } else {
      new NewsTab("All Branch",new NewsList(newsType: "All Branch",date_start: date_start,date_end: date_end,rmsBloc: rmsBloc,channel: channel  ));
    }






    setState(() {
      var formatter = new DateFormat('yyyy-MM-dd');


      date_start = formatter.format(new DateTime.now()
         );
      date_end = formatter.format(new DateTime.now());

      rmsBloc.dispatch(DateRange(
          result: [],
          start_date: date_start,
          end_date: date_end));


      channel.push("daily_sales", {
        "date_start": rmsBloc.currentState.startDate,
        "date_end": rmsBloc.currentState.endDate,"organization_code": widget.channel.user,"branch_name": rmsBloc.currentState.currentBranchName
      });


      channel.on("daily_sales_reply", (Map payload) {
        result = payload["result"];
        result2 = payload["result2"];

        rmsBloc.dispatch(DailySales(result: result,result2: result2));
      });
    });

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.orangeAccent,
        title: new TabBar(
          controller: _tabController,
          tabs: myTabs.map((NewsTab item){      //NewsTab可以不用声明
            return new Tab(text: item.text??'All Branch');
          }).toList(),
          indicatorColor: Colors.white,
          isScrollable: true,   //水平滚动的开关，开启后Tab标签可自适应宽度并可横向拉动，关闭后每个Tab自动压缩为总长符合屏幕宽度的等宽，默认关闭
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
class NewsList extends StatefulWidget{
  final String newsType;
  String date_start;
  String date_end;
  dynamic rmsBloc;
  Channel channel;



  @override
  NewsList({Key key, this.newsType,this.date_start,this.date_end,this.rmsBloc,this.channel} ):super(key:key);

  _NewsListState createState() => new _NewsListState();
}

class _NewsListState extends State<NewsList>{


  List data;
  var result;
  Channel channel;
  RmsBloc rmsBloc;
  String date_start;
  String date_end;
  Widget listWidgets;
  Widget listWidgets2;



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

    channel= widget.channel;



    rmsBloc.dispatch(BranchName(currentBranchName: widget.newsType));


    return BlocBuilder(
        bloc: rmsBloc,
        builder: (BuildContext context, RmsState state) {

          if  (rmsBloc.currentState.chartData != null) {
            if (rmsBloc.currentState.chartData.length > 0) {
              listWidgets = charts.BarChart(
                  _createSampleData(rmsBloc.currentState.chartData), animate: false);
            }
          }

          if  (rmsBloc.currentState.chartData2 != null) {
            if  (rmsBloc.currentState.chartData2.length > 0 ) {
              listWidgets2=
                  charts.PieChart(_createSampleData2(rmsBloc.currentState.chartData2), defaultRenderer: new charts.ArcRendererConfig(
                      arcWidth: 60,
                      arcRendererDecorators: [new charts.ArcLabelDecorator()]));
            }

          }

          return Scaffold(

              body: SingleChildScrollView(

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
//                    Container(
//                      child: listWidgets,
//                      color: Colors.white,
//                      height: 300.0,
//                      width: 500.0,
//                    ),
                    Divider(),
                    Text('Sales Details'),
                    TableList(channel: channel, rmsBloc: rmsBloc),
//                    Divider(),
//                    Container(
//                      child: listWidgets2,
//                      color: Colors.white,
//                      height: 350.0,
//                      width: 300.0,
//                    ),
                    Divider( color: Colors.deepOrange,height: 50,),
                    Text('Top 10 Items'),
                    TableListTwo(channel: channel, rmsBloc: rmsBloc),
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

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales2, String>> _createSampleData2(
      List<dynamic> salesData2) {
    List<LinearSales2> data2 = [];

    for (var data3 in salesData2) {


      try {
        data2.add(     new LinearSales2(data3["item"], double.parse(data3["sales"])) ,);
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
        data: data2, labelAccessorFn: (LinearSales2 row, _) => '${row.item}: ${row.sales}',
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
        DataCell(Text(name["day"].toString())),
        DataCell(Text(name["sales"].toString()))
      ]));
    }

    return DataTable(columns: <DataColumn>[
      DataColumn(
        label: Text("Day"),
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


class TableListTwo extends StatefulWidget {
  var rmsBloc;

  Channel channel;
  TableListTwo({this.rmsBloc, this.channel});

  TableListTwoState createState() => TableListTwoState();
}

class TableListTwoState extends State<TableListTwo> {
  @override
  Widget build(BuildContext context) {
    final RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);
    List<DataRow> dr2 = [];
    if  (rmsBloc.currentState.chartData2 != null) {
      if  (rmsBloc.currentState.chartData2.length > 0 ) {
        for (var name in widget.rmsBloc.currentState.chartData2) {
          dr2.add(DataRow(cells: <DataCell>[
            DataCell(Text(name["item"])),
            DataCell(Text(name["sales"]))
          ]));
        }
      }

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
    ], rows: dr2);
  }
}





