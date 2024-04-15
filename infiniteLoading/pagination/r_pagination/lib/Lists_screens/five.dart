import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiveScreen extends ConsumerStatefulWidget {
  const FiveScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FiveScreenState();
}

class _FiveScreenState extends ConsumerState<FiveScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 5,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              height: 100,
              width: 50,
              color: Colors.blue,
            ),
          );
        });
  }
}
