import 'package:flutter/material.dart';
import 'package:micmory/backvoid.dart';
import 'package:micmory/list_paper.dart';
import 'package:micmory/search.dart';
import 'package:micmory/logo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'micmory',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<String, void Function(bool)> callbackTrans = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackVoid(callbackTrans),
          Contents(),
          ListPaper(callbackTrans),
        ],
      ),
    );
  }
}

class Contents extends StatefulWidget {
  const Contents({super.key});

  @override
  State<Contents> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Logo(size: 120, bottom: 25),
          Search(height: 30, width: 250),
        ],
      ),
    );
  }
}
