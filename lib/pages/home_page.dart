import 'package:flutter/material.dart';

import './SidebarPage.dart'; //侧边栏
import '../channel/channel.dart';
import './TopTabPages/TopTabPage_1.dart';
import './TopTabPages/TopTabPage_2.dart';
import './TopTabPages/TopTabPage_3.dart';
import './TopTabPages/TopTabPage_4.dart';
import '../rms.dart';
import '../flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';

class HomePage extends StatefulWidget {
  Channel channel;

  HomePage({this.channel});
  @override
  _HomePageState createState() => new _HomePageState();
}

//用于使用到了一点点的动画效果，因此加入了SingleTickerProviderStateMixin
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String date_start;
  String date_end;
  Channel channel;
  Widget listWidgets;

  final List<Tab> _bottomTabs = <Tab>[
    new Tab(
        text: 'Today',
        icon: new Icon(Icons.today)), //icon和text的显示顺序已经内定，如需自定义，到child属性里面加吧
    new Tab(text: 'Yesterday', icon: new Icon(Icons.weekend)),
//    new Tab(text: 'Last 7',icon: new Icon(Icons.view_week)),
//    new Tab(text: 'Costume',icon: new Icon(Icons.loop)),
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

          if (rmsBloc.currentState.startDate == null) {
            var formatter = new DateFormat('yyyy-MM-dd');

            date_start = formatter.format(new DateTime.now());
            date_end = formatter.format(new DateTime.now());
          } else {
            date_start = rmsBloc.currentState.startDate;
            date_end = rmsBloc.currentState.endDate;
          }

          if (rmsBloc.currentState.list != null) {
            branchStings = rmsBloc.currentState.list;
          } else {
            branchStings = ["All Branch"];
          }


          return new Scaffold(
              appBar: new AppBar(
                backgroundColor: Colors.deepOrange,
                title: new Text('Home'),
                actions: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Text(
                            "${rmsBloc.currentState.startDate} - ${rmsBloc.currentState.endDate} ",
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ), //头部的标题AppBar
              drawer: new Drawer(
                //侧边栏按钮Drawer
                child: new ListView(
                  children: <Widget>[
                    new UserAccountsDrawerHeader(
                      //Material内置控件
                      accountName: new Text('CYC'), //用户名
                      accountEmail: new Text('example@126.com'), //用户邮箱
                      currentAccountPicture: new GestureDetector(
                        //用户头像
                        onTap: () => print('current user'),
                        child: new CircleAvatar(
                          //圆形图标控件
                          backgroundImage: new NetworkImage(
                              'https://upload.jianshu.io/users/upload_avatars/7700793/dbcf94ba-9e63-4fcf-aa77-361644dd5a87?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'), //图片调取自网络
                        ),
                      ),
                      otherAccountsPictures: <Widget>[
                        //粉丝头像
                        new GestureDetector(
                          //手势探测器，可以识别各种手势，这里只用到了onTap
                          onTap: () =>
                              print('other user'), //暂且先打印一下信息吧，以后再添加跳转页面的逻辑
                          child: new CircleAvatar(
                            backgroundImage: new NetworkImage(
                                'https://upload.jianshu.io/users/upload_avatars/10878817/240ab127-e41b-496b-80d6-fc6c0c99f291?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () => print('other user'),
                          child: new CircleAvatar(
                            backgroundImage: new NetworkImage(
                                'https://upload.jianshu.io/users/upload_avatars/8346438/e3e45f12-b3c2-45a1-95ac-a608fa3b8960?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
                          ),
                        ),
                      ],
                      decoration: new BoxDecoration(
                        //用一个BoxDecoration装饰器提供背景图片
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          // image: new NetworkImage('https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg')
                          //可以试试图片调取自本地。调用本地资源，需要到pubspec.yaml中配置文件路径
                          image: new ExactAssetImage('images/lake.jpg'),
                        ),
                      ),
                    ),
                    new ListTile(
                        //第一个功能项
                        title: new Text('First Page'),
                        trailing: new Icon(Icons.arrow_upward),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new SidebarPage('First Page')));
                        }),
                    new ListTile(
                        //第二个功能项
                        title: new Text('Second Page'),
                        trailing: new Icon(Icons.arrow_right),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new SidebarPage('Second Page')));
                        }),
                    new ListTile(
                        //第二个功能项
                        title: new Text('Second Page'),
                        trailing: new Icon(Icons.arrow_right),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed('/a');
                        }),
                    new Divider(), //分割线控件
                    new ListTile(
                      //退出按钮
                      title: new Text('Close'),
                      trailing: new Icon(Icons.cancel),
                      onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
                    ),
                  ],
                ),
              ),
              body: new TabBarView(controller: _bottomNavigation, children: [
                //注意顺序与TabBar保持一直
                new News(
                    data: branchStings, channel: widget.channel, bloc: rmsBloc),
                new News2(
                    data: branchStings, channel: widget.channel, bloc: rmsBloc),
//                new News3(data: branchStings,channel: channel),
//                new News4(data: branchStings,channel: channel),
              ]),
              bottomNavigationBar: new Material(
                color: Colors.deepOrange, //底部导航栏主题颜色
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
