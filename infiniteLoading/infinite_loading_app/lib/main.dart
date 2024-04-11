import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_loading_app/view/normalPagination.dart';
import 'package:infinite_loading_app/view/test.dart';
import 'package:infinite_loading_app/view/usingRiverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pagination Example',
      home: TestT(),
    );
  }
}
