import 'package:flutter/material.dart';
import 'sales.dart';
import 'monthly_sales.dart';
import 'channel/channel.dart';

class MainSalesPage extends StatefulWidget {
  Channel channel;
  MainSalesPage({this.channel});

  MainSalesPageState createState() => MainSalesPageState();
}


class MainSalesPageState extends State<MainSalesPage>{
 Channel channel;
 var result;
  @override
  Widget build(BuildContext context) {
channel = widget.channel;
    return Scaffold(
        appBar: AppBar(
          title: Text('Sales Page'),
        ),
        body: Container(

          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new RaisedButton(
                child: Text('Daily Sales'),
                onPressed: () async {

                  await channel.push("daily_sales", {"date_start": "2019-02-01", "date_end": "2019-02-28"});

                  channel.on("daily_sales_reply", (Map payload) {
                      setState(() {
                        result = payload["result"];
                      });

                  });

if (result != null) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SalesPage(salesData: result,)),
  );
}



                },
              ),
             new RaisedButton(
                child: Text('Monthly Sales'),
                onPressed: () async {

                  await channel.push("monthly_sales", {"date_start": "2019-02-01", "date_end": "2019-02-28"});

                  channel.on("monthly_sales_reply", (Map payload) {


                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MonthlySales(salesData: payload["result"],)),
                    );

                  });



                },
              )
              ,new RaisedButton(
                child: Text('Yearly Sales'),
                onPressed: () async {

                  await channel.push("daily_sales", {"date_start": "2019-02-01", "date_end": "2019-02-28"});

                  channel.on("daily_sales_reply", (Map payload) {


                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SalesPage(salesData: payload["result"],)),
                    );

                  });
                },
              )


            ],
          )



//
//          child: RaisedButton(
//            child: Text('Sales Chart'),
//            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => SalesPage()),
//              );
//            },
//          ),



        ));
  }
}
