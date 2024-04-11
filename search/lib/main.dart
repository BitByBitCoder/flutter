import 'package:flutter/material.dart';
import 'package:serarch/homeScreen.dart';
import 'package:serarch/insex%20search/insex_search.dart';
import 'package:serarch/search_api/search_api.dart';
import 'package:serarch/testsearchT.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestSearch(),
    );
  }
}
