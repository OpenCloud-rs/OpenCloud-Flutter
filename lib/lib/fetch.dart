import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:opencloud_mobile/component/card.dart';

class FetchApp extends StatefulWidget {
  FetchApp({Key key, this.ip, this.name, this.password}) : super(key: key);

  final String ip;
  final String name;
  final String password;

  @override
  _FetchAppState createState() =>
      _FetchAppState(ip: ip, password: password, name: name);
}

class _FetchAppState extends State<FetchApp> {
  _FetchAppState({this.ip, this.password, this.name});

  List data;
  String ip;
  String token;
  String name;
  String password;
  String current;
  Color color;

  // Function to get the JSON data
  Future<String> getJSONData() async {
    color = Colors.white;
    if (this.token == null || this.token.isEmpty) {
      await this.getToken(name, password, ip).then((String value) => this.token = value);
    }
    var url = (this.ip + "/api/file" + this.current).toString();
    var hearders = {
      "token": "${this.token}"
    };

    var response = await http.get(Uri.encodeFull(url), headers: hearders);
    setState(() {
      try {
        var decoded = json.decode(response.body.toString());
        data = decoded['content'];
        color = Colors.black;
      } catch (e) {
        color = Colors.red;
        data = json.decode('{"content" : [{"result": true,"name": "Error","size": 305603,"created": "18-12-2020 22:05:23","modified": "18-12-2020 22:05:23","ftype": "Error"}]}')["content"] as List<dynamic>;
        return "Error";
      }
    });

    return "Successfull";
  }

  void checkVar() {
    if (this.ip == null || this.ip.isEmpty) {
      this.ip = "http://192.168.1.103:8081";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OpenCloud"),
        backgroundColor: color,
      ),
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          return _buildCard(data[index]);
        });
  }

  Widget _buildCard(dynamic item) {
    return MyCard(
      title: item['name'] == null ? '' : utf8.decode(item['name'].toString().codeUnits),
      but: item['ftype'].toString(),
      func: () => {changeFolder(item['name'] == null ? '' : item['name'])},
    );
  }

  void changeFolder(String name) {
    setState(() {
      this.current = (this.current + name + "/").toString();
    });
    this.getJSONData();
  }

  Future<String> getToken(String name, String password, String ip) async {
    var tocall = (ip + "/api/user/login").toString();
    print(tocall);
    var response;
    var token;
    try {
      var user = {"name": "Xx", "password": "Xx"};
      var body = jsonEncode(user);
      print(body);
      response = await http.post(
          // Encode the url
          Uri.encodeFull(tocall),
          // Only accept JSON response
          headers: {"Content-Type": "application/json"},
          body: body);
      if (response.statusCode != 200) {
        print("${response.body}");
        print("Not a status : ${response.statusCode}");
      } else {
        token = response.body;
        print(token);
      }
    } catch (e) {
      print(e);
    }

    return token;
  }


  @override
  void initState() {
    super.initState();
    this.checkVar();
    this.getJSONData();
  }
}
