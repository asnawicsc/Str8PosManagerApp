import 'package:flutter/material.dart';
import '../channel/channel.dart';
import 'home_page.dart';
import '../flutter_bloc/flutter_bloc.dart';
import '../rms.dart';
Channel _chatChannel;


class SidebarPage extends StatefulWidget {
  createState() => SidebarPageState();
}


class SidebarPageState extends State<SidebarPage> {



  RmsBloc bloc;
  var username = TextEditingController();
  var password = TextEditingController();




  bool isChecked = true;

  bool isChecked2 = true;





  @override
  Widget build(BuildContext context) {




    final RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);
    print("state: ${rmsBloc.currentState.showTable}");
    if (rmsBloc.currentState.showTable == true){
      isChecked2 == true;

    }else
      {
        isChecked2 == false;
      }

    if (rmsBloc.currentState.showGraph == true){
      isChecked == true;

    }else
    {
      isChecked == false;
    }


    return BlocBuilder(
        bloc: rmsBloc,
        builder: (BuildContext context, RmsState state) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Setting Page'),
        ),
        body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[

                SizedBox(height: 50.0),
                CheckboxListTile(
                  title: Text("Show Graph"),
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                ),
                SizedBox(height: 12.0),

                CheckboxListTile(
                  title: Text("Show Table"),
                  value: isChecked2,
                  onChanged: (value) {
                    setState(() {
                      isChecked2 = value;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),

                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[

                    RaisedButton(
                        child: Text('SUBMIT'),
                        onPressed: () {

                          print("isChecked ${isChecked}");
                          print("isChecked2 ${isChecked2}");


                          rmsBloc.dispatch(Setting(
                              showTable: isChecked2,
                              showGraph: isChecked,
                            ));

                          _chatChannel = Channel(user: username.text, licenseKey: password.text);
//
//
//                          _chatChannel.socket.onError((error) => print("socket.onError: $error"));
//                          _chatChannel.socket.onClose((msg) => print("socket.onClose: $msg"));
//
//                          _chatChannel.push("organization_branch", {
//                            "organization_code": _chatChannel.user
//
//                          });



                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(channel: _chatChannel)),
                          );
//                      return showDialog(
//                        context: context,
//                        builder: (context) {
//                          return AlertDialog(
//                            // Retrieve the text the user has typed in using our
//                            // TextEditingController
//                            content: Text(username.text + password.text)
//
//                          );
//                        },
//                      );
                        }
                    )
                  ],
                )

              ],
            )
        )
    );
        });
  }
}