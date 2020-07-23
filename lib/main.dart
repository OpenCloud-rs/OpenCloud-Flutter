import 'package:flutter/material.dart';
import 'package:opencloud_mobile/component/form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = "Form";
    return MaterialApp(debugShowCheckedModeBanner: false,title: appTitle, home: IpForm());
  }
}
