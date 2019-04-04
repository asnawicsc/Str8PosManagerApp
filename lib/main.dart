import 'package:flutter/material.dart';
import 'login.dart';
import 'channel/channel.dart';
import 'rms.dart';
import 'flutter_bloc/flutter_bloc.dart';
import 'main_sales.dart';
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
  var username = TextEditingController();
  var password = TextEditingController();

  Widget build(BuildContext context) {
    final RmsBloc rmsBloc = BlocProvider.of<RmsBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),
          backgroundColor: Color(0xFF444152),
        ),
        body: SafeArea(
            child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 20.0),
            Column(
              children: <Widget>[
                Image.asset('assets/images/str8_pos.png'),
                SizedBox(height: 20.0),
              ],
            ),
            SizedBox(height: 50.0),
            TextField(

              controller: username,
              decoration: InputDecoration(
                fillColor: Color(0xFF444152),

                labelText: 'Username',
                filled: true,
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: password,
              decoration: InputDecoration(
                fillColor: Color(0xFF444152),

                labelText: 'Password',

                filled: true,
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  color: Color(0xFF444152),
                  textColor: Color(0xFFFFFFFFF),
                  child: Text('CANCEL'),
                  onPressed: () {
                    username.clear();
                    password.clear();
                  },
                ),
                RaisedButton(
                  color: Color(0xFF444152),
                    textColor: Color(0xFFFFFFFFF),
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


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage(channel: _chatChannel)),
                      );
                    }
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => MainSalesPage(channel: _chatChannel)),
//                          );
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
                    })
              ],
            )
          ],
        )));
  }
}
