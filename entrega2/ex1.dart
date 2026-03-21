import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter is Fun!'),
          backgroundColor: Colors.green[700],
          foregroundColor: Colors.white,
        ),
        body: Container(
          width: 100,
          height: 100,
          color: Colors.red,
          margin: EdgeInsets.all(80.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Hi Mom!"),
              SizedBox(width: 8),
              Icon(Icons.backpack),
            ],
          ),
        ),
      ),
    );
  }
}