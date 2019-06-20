import 'package:flutter/material.dart';

import 'channel/channel.dart';
import 'rms.dart';
import 'flutter_bloc/flutter_bloc.dart';

import 'pages/home_page.dart';


Channel _chatChannel;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  RmsBloc rmsBloc = new RmsBloc();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {


    return BlocProvider<RmsBloc>(
        bloc: rmsBloc,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: LoginPage(),
        ));
  }
}



class LoginPage extends StatefulWidget {
  // This widget is the root of your application.


  @override
  _LoginPageState createState() => _LoginPageState();



}


class _LoginPageState extends State<LoginPage> {
  final TextEditingController username = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  RmsBloc rmsBloc = new RmsBloc();
  @override


String data;
String data2;


  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Widget build(BuildContext context)  {
    final RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);



   if (rmsBloc.currentState.username != null)
     {data == rmsBloc.currentState.username ;}

    if (rmsBloc.currentState.password != null)
    { data2 == rmsBloc.currentState.password ;}

    print("ss${rmsBloc.currentState.username}");
    print("data${data}");
    print("data2${data2}");

    return MaterialApp(
        debugShowCheckedModeBanner: false,


        title: "Welcome to Flutter",
        home: new Material(

            child: new Container (
                padding: const EdgeInsets.all(30.0),
                color: Color(0xFF444152),
                child: new Container(
                  child: new Center(
                      child: new Column(
                          children : [
                            new Padding(padding: EdgeInsets.only(top: 10.0)),
                            Image.asset('assets/images/str8_pos.png'),
                            SizedBox(height: 20.0),
                            new Padding(padding: EdgeInsets.only(top: 20.0)),
                            new TextFormField(

                              controller: username,



                              decoration: new InputDecoration(


                                labelText: "Enter Username",
                                fillColor: Colors.grey,
                                filled: true,




                                //fillColor: Colors.green
                              ),
                              validator: (val) {
                                if(val.length==0) {
                                  return "Username cannot be empty";
                                }else{
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                            new Padding(padding: EdgeInsets.only(top:10.0)),
                            new TextFormField(
                              controller: password,

                              decoration: new InputDecoration(
                                labelText: "Enter Password",
                                fillColor: Colors.grey,
                                filled: true,

                                //fillColor: Colors.green
                              ),
                              validator: (val2) {
                                if(val2.length==0) {
                                  return "Password cannot be empty";
                                }else{
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                              obscureText: true,
                            ),
                            ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  color: Color(0xfff65aa3),
                                  textColor: Colors.white,
                                  child: Text('CANCEL'),
                                  onPressed: () {
                                    username.clear();
                                    password.clear();
                                  },
                                ),
                                RaisedButton(
                                    color: Color(0xfff65aa3),
                                    textColor: Colors.white,
                                    child: Text('LOGIN'),
                                    onPressed: () {

                                      print("user: ${username.text}");

                                      if  (username.text.isEmpty  ){

                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // return object of type Dialog
                                            return AlertDialog(
                                              title: new Text("Warning"),
                                              content: new Text("Please key In Username/Password"),
                                              actions: <Widget>[
                                                // usually buttons at the bottom of the dialog
                                                new FlatButton(
                                                  child: new Text("Close"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );


                                      }
                                      else if (password.text.isEmpty){ showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            title: new Text("Warning"),
                                            content: new Text("Please key In Username/Password"),
                                            actions: <Widget>[
                                              // usually buttons at the bottom of the dialog
                                              new FlatButton(
                                                child: new Text("Close"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );}
                                      else {
                                        _chatChannel = Channel(
                                            user: username.text, licenseKey: password.text);


                                        rmsBloc.dispatch(Login(
                                            username: username.text, password: password.text));

                                        _chatChannel.socket
                                            .onError((error) => print("socket.onError: $error"));
                                        _chatChannel.socket
                                            .onClose((msg) => print("socket.onClose: $msg"));


                                        _chatChannel.push("organization_branch", {
                                          "organization_code": _chatChannel.user
                                        });

                                        _chatChannel.socket.disconnect();


                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage(channel: _chatChannel)),
                                        );


                                      }
//
                                    })
                              ],
                            )
                          ]
                      )
                  ),

                )
            )
        )
    );


  }
}
