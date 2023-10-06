import 'package:flutter/material.dart';
import 'home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("FlutterNim"), Text("Leonardo Paschoa Braga"), Text("RA: 1431432312005")],
          ),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
        ),
        body: const SingleChildScrollView(
          child: Home(),
        ),
      ),
    );
  }
}
