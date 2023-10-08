import 'package:flutter/material.dart';
import 'package:flutternim/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("FlutterNim", style: TextStyle(fontSize: 15),), SizedBox(height: 1.0), Text("Leonardo Paschoa Braga", style: TextStyle(fontSize: 15),), SizedBox(height: 1.0), Text("RA: 1431432312005", style: TextStyle(fontSize: 15),)],
          ),
          backgroundColor: Colors.deepOrange,
        ),
        body: const SingleChildScrollView(
          child: Home(),
        ),
      ),
    );
  }
}
