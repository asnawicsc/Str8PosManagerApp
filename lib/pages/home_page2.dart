import 'package:flutter/material.dart';

import './SidebarPage.dart'; //侧边栏
import '../channel/channel.dart';

import './TopTabPages/TopTabPage_5.dart';
import './TopTabPages/TopTabPage_6.dart';
import './TopTabPages/TopTabPage_7.dart';
import '../rms.dart';
import '../flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



class HomePage2 extends StatefulWidget {
  Channel channel;

  HomePage2({this.channel});
  @override
  _HomePage2State createState() => new _HomePage2State();
}

//用于使用到了一点点的动画效果，因此加入了SingleTickerProviderStateMixin
class _HomePage2State extends State<HomePage2>
    with SingleTickerProviderStateMixin {
  String date_start;
  String date_end;
  Channel channel;
  Widget listWidgets;

  final List<Tab> _bottomTabs = <Tab>[
    new Tab(
        text: 'This Month',
        icon: new Icon(Icons.today)), //icon和text的显示顺序已经内定，如需自定义，到child属性里面加吧
    new Tab(text: "Last Month", icon: new Icon(Icons.assignment_return)),
    new Tab(text: 'This Year',icon: new Icon(Icons.view_week)),

  ];

  //定义底部导航Tab
  TabController _bottomNavigation;

  //初始化导航Tab控制器
  @override
  void initState() {
    super.initState();
    _bottomNavigation = new TabController(
      vsync: this, //动画处理参数
      length: _bottomTabs.length, //控制Tab的数量
    );
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _bottomNavigation.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    var channel = widget.channel;
    List<String> branchStings = ["All Branch"];

    final RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);

    return BlocBuilder(
        bloc: rmsBloc,
        builder: (BuildContext context, RmsState state) {
//          if (rmsBloc.currentState.list != null) {
//            for (var i = 0; i < rmsBloc.currentState.list.length; i++) {
//              branchStings.add(rmsBloc.currentState.list[i]);
//            }
//          } else {
//            branchStings = ["All Branch"];
//          }

          channel.on("monthly_sales_reply_all", (Map payload) {


            print("res: ${payload["result"]}");

            rmsBloc.dispatch(MonthlySalesAll( total_data4: payload["result"],total_data5: payload["result2"],total_data6: payload["result3"]));

          });

          List total_data4 = [];
          List total_data5 = [];
          List total_data6 = [];

          if (rmsBloc.currentState.total_data4 != null) {
            total_data4 = rmsBloc.currentState.total_data4;
          } else {
            total_data4 = [];
          }

          if (rmsBloc.currentState.total_data5 != null) {
            total_data5 = rmsBloc.currentState.total_data5;
          } else {
            total_data5 = [];
          }

          if (rmsBloc.currentState.total_data6 != null) {
            total_data6 = rmsBloc.currentState.total_data6;
          } else {
            total_data6 = [];
          }







          channel.on("organization_branch_reply", (Map payload) {
            List<String> branchStings = [];

            if (branchStings != null) {
              for (var i = 0; i < payload["result"].length; i++) {
                branchStings.add(payload["result"][i]);
              }
            } else {
              branchStings = ["All Branch"];
            }



            rmsBloc.dispatch(OrganzationBranch(list: branchStings));
          });

          if (rmsBloc.currentState.startMonth == null) {
            var formatter = new DateFormat('MM');
            date_start = formatter.format(new DateTime.now());
            date_end = formatter.format(new DateTime.now());
          } else {

            date_start = rmsBloc.currentState.startMonth;
            date_end = rmsBloc.currentState.endMonth;
          }



          if (rmsBloc.currentState.list != null) {
            branchStings = rmsBloc.currentState.list;
          } else {
            branchStings = ["All Branch"];
          }



          return new Scaffold(
              appBar: new AppBar(
                backgroundColor: Color(0xFF444152),
                title: new Text('Monthly'),
                actions: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Text(
                            "Month : ${date_start}",
                            textAlign: TextAlign.start,
                          ),

                        ],
                      ),

                    ],
                  )
                ],
              ), //头部的标题AppBar
              drawer: new Drawer(
          child: Container(
          color: Color(0xFF444152),

                //侧边栏按钮Drawer
                child: new ListView(
                  children: <Widget>[
                    new UserAccountsDrawerHeader(
                      //Material内置控件
                      accountName: new Text(rmsBloc.currentState.username), //用户名
                      accountEmail: new Text(''), //用户邮箱
                      currentAccountPicture: new GestureDetector(
                        //用户头像
                        onTap: () => print('current user'),
                        child: new CircleAvatar(
                          //圆形图标控件
                            backgroundImage: new AssetImage('assets/images/str8_pos.png')//图片调取自网络
                        ),
                      ),
                      otherAccountsPictures: <Widget>[


                      ],


                    ),
                    new ListTile(   //第二个功能项
                        title: Row(

                          children: <Widget>[
                            Expanded(flex: 1, child: Icon(Icons.today, color: Colors.white,
                            )),
                            Expanded(flex: 4, child: Text(
                              "Switch To Daily Sales",
                              style: TextStyle(color: Colors.white),
                            ))
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(channel: widget.channel)),
                          );
                        }
                    ),
                    new ListTile(   //第二个功能项
                        title: Row(

                          children: <Widget>[
                            Expanded(flex: 1, child: Icon(Icons.today, color: Colors.white,
                            )),
                            Expanded(flex: 4, child: Text(
                              "Switch To Monthly Sales",
                              style: TextStyle(color: Colors.white),
                            ))
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage2(channel: widget.channel)),
                          );
                        }
                    ),
                    new ListTile(
                      //第一个功能项
                        title: Row(

                          children: <Widget>[
                            Expanded(flex: 1, child: Icon(Icons.settings, color: Colors.white,
                            )),
                            Expanded(flex: 4, child: Text(
                              "View Settings",
                              style: TextStyle(color: Colors.white),
                            ))
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SidebarPage()),
                          );
                        }),

                    new Divider(), //分割线控件


                    new ListTile(
                      //退出按钮
                      title: Row(

                        children: <Widget>[
                          Expanded(flex: 1, child: Icon(Icons.close, color: Colors.white,
                          )),
                          Expanded(flex: 4, child: Text(
                            "Close",
                            style: TextStyle(color: Colors.white),
                          ))
                        ],
                      ),
                      onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
                    ),
                    new Divider(),    //分割线控件
                    new ListTile(   //退出按钮
                      title: Row(

                        children: <Widget>[
                          Expanded(flex: 1, child: Icon(Icons.exit_to_app, color: Colors.white,
                          )),
                          Expanded(flex: 4, child: Text(
                            "Log Out",
                            style: TextStyle(color: Colors.white),
                          ))
                        ],
                      ),
                      onTap: () {


//                        widget.channel.socket.disconnect();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                            builder: (context) =>
                            new LoginPage()), (Route<dynamic> route) => false);



                      },

                    ),
                  ],
                ),
              ),),
              body: new TabBarView(controller: _bottomNavigation, children: [
                //注意顺序与TabBar保持一直
                new News5(
                    data: branchStings,total4: total_data4,total5: total_data5,total6: total_data6, channel: widget.channel, bloc: rmsBloc),
                new News6(
                    data: branchStings,total4: total_data4,total5: total_data5,total6: total_data6, channel: widget.channel, bloc: rmsBloc),
                new News7(
                    data: branchStings,total4: total_data4,total5: total_data5,total6: total_data6, channel: widget.channel, bloc: rmsBloc),

              ]),
              bottomNavigationBar: new Material(
                color: Color(0xFF444152),
                child: new TabBar(
                  controller: _bottomNavigation,
                  tabs: _bottomTabs,

                  indicatorColor: Colors.white,
                  //tab标签的下划线颜色
                ),
              ));
        });
  }
}
