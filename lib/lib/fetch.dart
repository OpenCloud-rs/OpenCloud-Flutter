import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:opencloud_mobile/component/card.dart';

class FetchApp extends StatefulWidget {
  FetchApp({Key key, this.ip}) : super(key: key);

  final String ip;
  @override
  _FetchAppState createState() => _FetchAppState(ip: ip);
}

class _FetchAppState extends State<FetchApp> {
  _FetchAppState({this.ip});
  List data;
  final String ip;
  String subip = "/api/";
  // Function to get the JSON data
  Future<String> getJSONData(String ip, String subip) async {
    var tocall = (ip + subip).toString();
    print(tocall);
    var response = await http.get(
        // Encode the url

        Uri.encodeFull(tocall),
        // Only accept JSON response
        headers: {"Accept": "application/json"});

    setState(() {
      // Get the JSON data
      data = json.decode(response.body)['content'];
    });

    return "Successfull";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OpenCloud"),
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
          // return _buildRow(data[index]);
        });
  }

  Widget _buildCard(dynamic item) {
    return MyCard(
      title: new Text(item['name'] == null ? '' : item['name']),
      but: new Text(item['ftype'].toString()),
      func: () => {changeFolder(item['name'] == null ? '' : item['name'])},
    );
  }

  void changeFolder(String name) {
    subip = subip.toString() + name;
    this.getJSONData(ip, subip);
  }

  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    this.getJSONData(ip, subip);
  }
}
