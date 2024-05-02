import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControllerP extends StateNotifier<int> {
  ControllerP() : super(0) {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      print('This line will be printed every second');
    });
  }

  void increment() {
    state++;
    runLoop() {
      // Do some work here
      print('This line will be printed repeatedly');

      // Schedule the next iteration of the loop
      Timer(Duration(seconds: 1), runLoop);
    }
  }

  void decrement() {
    if (state > 0) {
      state--;
    }
  }
}

final cProvider = StateNotifierProvider<ControllerP, int>((ref) {
  return ControllerP();
});
