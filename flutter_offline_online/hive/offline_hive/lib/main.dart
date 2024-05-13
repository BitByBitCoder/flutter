import 'package:flutter/material.dart';


import 'package:hive_flutter/adapters.dart';

import 'package:offline_hive/hive_learrn/model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HiveModelAdapter());
}

class TT extends StatelessWidget {
  const TT({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Text('hello'));
  }
}
