import 'package:flutter/material.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  @override
  void initState() {
    firstadd();
    // TODO: implement initState
    super.initState();
  }

  List<String> a = ['hello', 'hruaia', 'lala', 'rala'];

  List<String> d = [];

  void firstadd() {
    d.addAll(a);
  }

  void call(String b) {
    print(a);
    final result = a.where((element) => element.startsWith((b))).toList();
    d.clear();
    d.addAll(result);
  }

  final controller = TextEditingController();
  String c = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextField(
              onChanged: (value) {
                call(value);
                setState(() {});
              },
              controller: controller,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: d.length,
                  itemBuilder: (context, index) {
                    return Text('${d[index]}');
                  }),
            )
          ],
        ));
  }
}
