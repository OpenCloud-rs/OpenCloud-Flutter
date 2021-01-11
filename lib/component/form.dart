import 'package:flutter/material.dart';
import 'package:opencloud_mobile/lib/fetch.dart';

class IpForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IpFormState();
  }
}

class IpFormState extends State<IpForm> {
  String ip;
  String name;
  String password;

  final _formkey = GlobalKey<FormState>();

  Widget _buildIp() {
    return new Form(
        child: new Column(children: [
          TextFormField(
              decoration: InputDecoration(labelText: "Ip"),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your ip adress server';
                }
                return null;
              },
              onSaved: (String value) {
                ip = value;
              }),
          TextFormField(
              decoration: InputDecoration(labelText: "Name"),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your Name user';
                }
                return null;
              },
              onSaved: (String value) {
                name = value;
              }),
          TextFormField(
              decoration: InputDecoration(labelText: "password"),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your password user';
                }
                return null;
              },
              onSaved: (String value) {
                password = value;
              })
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Connection Page"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(50),
          child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildIp(),
                  SizedBox(height: 100),
                  RaisedButton(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    onPressed: () {
                      if (!_formkey.currentState.validate()) {
                        return;
                      }
                      _formkey.currentState.save();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FetchApp(ip: ip, name: name,password: password)));
                    },
                  )
                ],
              )),
        ));
  }
}
