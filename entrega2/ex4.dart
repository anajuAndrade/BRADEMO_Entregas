import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Insert Image Example'),
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
        ),
        
        body: Column(
  children: [

    Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 180,
        width: 260,
        child: Image.network(
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          fit: BoxFit.cover,
        ),
      ),
    ),

    SizedBox(
      height: 180, 
      width: double.infinity,
      child: Image.network(
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
        fit: BoxFit.cover,
      ),
    ),

  ],
),
      ),
    );
  }
}