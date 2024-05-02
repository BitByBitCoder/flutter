import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TimeScrenn extends ConsumerStatefulWidget {
  const TimeScrenn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimeScrennState();
}

class _TimeScrennState extends ConsumerState<TimeScrenn> {
  @override
  void initState() {
    getTime();

    // TODO: implement initState
    super.initState();
  }

  String t = '';
  getTime() {
    Timer timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      final time = DateFormat.jms().format(DateTime.now());
      setState(() {
        t = time;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [Text('$t')],
      ),
    );
  }
}
