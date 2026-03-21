import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stack & Positioned Widget'),
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
          centerTitle: true
        ),
       
        body: Stack(
  children: <Widget>[

    Positioned(
      top: 50,
      left: 50,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.lightGreen,
        child: Text("Green", style: TextStyle(color: Colors.white)),
      ),
    ),
    Positioned(
      top: 80,
      left: 80,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
        child: Text("Red", style: TextStyle(color: Colors.white)),
      ),
    ),
    Positioned(
      top: 120,
      left: 120,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.purple,
        child: Text("Purple", style: TextStyle(color: Colors.white)),
      ),
    ),
  ],
),
      ),
    );
  }
}