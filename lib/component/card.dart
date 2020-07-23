import 'package:flutter/material.dart';
class MyCard extends StatelessWidget{
  MyCard({this.title,this.but, this.func});
  final Widget title;
  final Text but;
  final func;
  @override
  Widget build(BuildContext context){
    return new Container(
        padding: new EdgeInsets.only(bottom: 3.0),
        child: new Card(
          child: new Container(
              padding: new EdgeInsets.all(35),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      this.title,
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text("type of item")
                      //new RaisedButton(onPressed: this.func, child: this.but)
                    ],
                  )
                ],
              )
          ),
        )
    );
  }
}