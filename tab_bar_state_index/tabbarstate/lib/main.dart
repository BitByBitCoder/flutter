import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabbarstate/home.dart';
import 'package:tabbarstate/provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabBar Example',
      home: HH(),
    );
  }
}

class HH extends ConsumerStatefulWidget {
  const HH({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HHState();
}

class _HHState extends ConsumerState<HH> {
  @override
  Widget build(BuildContext context) {
    final a = ref.watch(tabIndexProvider);
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Home()));
            },
            child: Text('hello')),
      ),
      body: Text('$a'),
    );
  }
}
