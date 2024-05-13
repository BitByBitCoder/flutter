import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_second/view/home_screen_without_future.dart';
import 'package:hive_second/view/homescreen.dart';
import 'package:hive_second/view/models.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonModelsAdapter());

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreenSecond(),
    );
  }
}
