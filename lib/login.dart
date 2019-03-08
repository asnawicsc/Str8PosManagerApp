import 'package:flutter/material.dart';
import 'main_sales.dart';
import 'channel/channel.dart';

Channel _chatChannel;
class LoginPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

   var username = TextEditingController();
   var password = TextEditingController();

  Widget build(BuildContext context)  {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),
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
                labelText: 'Username',
                filled: true,
              ),
            ),
            SizedBox(height: 12.0),

            TextField(
              controller: password,
              decoration: InputDecoration(
                labelText: 'Password',
              filled: true,
            ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: (){
                    username.clear();
                    password.clear();

                  },

                ),
                RaisedButton(
                  child: Text('LOGIN'),
                    onPressed: () {

                      _chatChannel = Channel(user: username.text, licenseKey: password.text);


                     _chatChannel.socket.onError((error) => print("socket.onError: $error"));
                      _chatChannel.socket.onClose((msg) => print("socket.onClose: $msg"));



 

                      _chatChannel.push("organization_branch", {
                        "organization_code": _chatChannel.user

                      });


                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainSalesPage(channel: _chatChannel)),
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
  }
}
