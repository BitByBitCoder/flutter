import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:statenotifier/pagination.dart';
import 'package:statenotifier/provider.dart';
import 'package:statenotifier/timescreen.dart';

void main() {
  runApp(MaterialApp(
    home: Pagination(),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: Home());
  }
}

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(cProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('$data'),
          TextButton(
              onPressed: () {
                ref.read(cProvider.notifier).increment();
              },
              child: Text('press')),
          TextButton(
              onPressed: () {
                ref.read(cProvider.notifier).decrement();
              },
              child: Text('ninus'))
        ],
      ),
    );
  }
}
