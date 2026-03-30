import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.blue,
    ).copyWith(
      scaffoldBackgroundColor: Colors.yellow,
    ),
    home: Home(),
  ),
);

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ThemeData (Sobrescreve)"),
      ),
      body: Center(
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.orange,
            ),
          ),
          child: Center(
            child: Text(
              "Widget",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}