import 'package:flutter/material.dart';

class Refff extends StatefulWidget {
  const Refff({super.key});

  @override
  State<Refff> createState() => _RefffState();
}

class _RefffState extends State<Refff> {
  // List items = ['item1', 'item2'];
  final listcontroler = ScrollController();
  final List items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
    'Item 11',
    'Item 12',
    'Item 13',
    'Item 14',
    'Item 15',
    'Item 16',
    'Item 17',
    'Item 18',
    'Item 19',
    'Item 20',
  ];

  @override
  void initState() {
    listcontroler.addListener(() {
      if (listcontroler.position.maxScrollExtent == listcontroler.offset) {
        print('end');
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));

          // items.add('item $nextItem');
          setState(() {});
        },
        child: Scaffold(
            appBar: AppBar(),
            body: ListView.builder(
                controller: listcontroler,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text('${items[index]}'),
                  );
                })));
  }
}
