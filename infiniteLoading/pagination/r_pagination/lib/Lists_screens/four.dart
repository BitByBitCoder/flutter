import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FourScreen extends ConsumerWidget {
  const FourScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      children: [
        c(),
        c(),
        c(),
        c(),
        c(),
      ],
    );
  }

  Container c() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 50,
        width: 50,
        color: Colors.amber,
      ),
    );
  }
}
