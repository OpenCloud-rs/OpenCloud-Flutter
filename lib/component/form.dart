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
  final _formkey = GlobalKey<FormState>();
  Widget _buildIp() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Ip"),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter your ip adress server';
        }
        return null;
      },
      onSaved: (String value) {
        ip = value;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Form Demo")),
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
                    child: Text("Submit", style: TextStyle(color: Colors.black, fontSize: 17),),
                    onPressed: () {if (!_formkey.currentState.validate()) {return;} _formkey.currentState.save(); Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "Fetch", ip:ip)));},
                  )
                ],
              )),
        ));
  }
}
