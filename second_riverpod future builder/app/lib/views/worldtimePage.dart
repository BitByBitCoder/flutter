import '../providers/worldtimeprovider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(futureWorldTime);
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Future provider test'),
          ),
          body: Column(
            children: [
              name.when(
                  data: (data) => Text('${data.timezone}'),
                  error: (err, stacktrace) => Text('err'),
                  loading: () => Text('loading'))
            ],
          )),
    );
  }
}
