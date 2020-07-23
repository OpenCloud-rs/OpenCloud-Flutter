import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:opencloud_mobile/component/card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<List<Folder>> fetchFolder(http.Client client, String ip) async {
  final response = await client.get(ip);
  return compute(parseFolder, response.body);
}
List<Folder> parseFolder(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Folder>((json) => Folder.fromJson(json)).toList();
}

class Folder {
  final bool result;
  final String type;
  final String name;

  Folder({this.result, this.type, this.name});

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      result: json['content']['result'] as bool,
      type: json['content']['type'] as String,
      name: json['content']['result'] as String,
    );
  }
}
class MyHomePage extends StatelessWidget {
  final String title;
  final String ip;
  MyHomePage({Key key, this.title, this.ip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Folder>>(
        future: fetchFolder(http.Client(), ip),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? FolderList(folder: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}


class FolderList extends StatelessWidget {
  final List<Folder> folder;

  FolderList({Key key, this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: folder.length,
      itemBuilder: (context, index) {
        return MyCard(title: new Text(folder[index].name) ,but: new Text(folder[index].type) ,func: () => {});
      },
    );
  }
}