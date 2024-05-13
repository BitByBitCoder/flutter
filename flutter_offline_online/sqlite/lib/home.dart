import 'package:flutter/material.dart';

class HH extends StatelessWidget {
  final List? id;
  const HH({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('${id!.first}'),
    );
  }
}
