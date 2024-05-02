import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/loading.dart';
import 'package:testapp/screens/userscreen.dart';
// ignore: depend_on_referenced_packages

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading(),
    );
  }
}
