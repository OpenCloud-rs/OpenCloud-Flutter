
import 'package:flutter/material.dart';

import 'package:opencloud_mobile/component/form.dart';


void main() => runApp(MyApp());

class RunApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(

        ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = "dd";
    return MaterialApp(
      title: appTitle,
      home: IpForm()
    );
  }

}

