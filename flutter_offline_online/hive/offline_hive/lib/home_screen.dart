import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final _mybox = Hive.box('mybox');
    print('${_mybox.get('name')}');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [ElevatedButton(onPressed: () {}, child: Text('read'))],
        ),
      ),
    );
  }
}
