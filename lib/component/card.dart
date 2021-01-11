import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  MyCard({this.title, this.but, this.func});
  final String title;
  final String but;
  final func;
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.only(bottom: 3.0),
        child: new Card(
            child: new InkWell(
          onTap: func,
          child: new Container(
              padding: new EdgeInsets.all(35),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(this.title),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(this.but),
                    ],
                  )
                ],
              )),
        )));
  }
}
