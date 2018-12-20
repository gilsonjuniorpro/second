import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data;

  Future<String> getData() async{
    http.Response response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {
          "Accept" : "Application/json"
        }
    );

    setState(() {
      data = json.decode(response.body);
    });

    return "success";
  }

  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: AppBar(
        title: const Text("Flutter JSON API"),
        backgroundColor: Colors.blueAccent,
      ),

      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
            margin: const EdgeInsets.all(4.0),
            child: new Text(
              "title: " + data[index]["title"] + "\n\nbody: " + data[index]["body"],
              style: new TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12.0,
                color: Colors.black,
                fontFamily: 'Roboto',
              ),
            ),
            elevation: 1,
          );
        },
      ),

    );
  }
}