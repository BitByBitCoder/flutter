import 'package:flutter/material.dart';

class Overlapping extends StatefulWidget {
  const Overlapping({super.key});

  @override
  State<Overlapping> createState() => _OverlappingState();
}

class _OverlappingState extends State<Overlapping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            listtt(),
            listtt(),
            listtt(),
            listtt(),
            listtt(),
            listtt(),
            listtt(),
            listtt(),
          ],
        ),
      ),
    );
  }

  Widget listtt() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rrukruk leh mi in rawk thubuai a ti sual ti tu te',
                      style: TextStyle(fontSize: 16),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            size: 16,
                          ),
                          Text(
                            '01',
                            style: TextStyle(fontSize: 14),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.black,
                            height: 16,
                            width: 1,
                          ),
                          Icon(
                            Icons.punch_clock,
                            size: 16,
                          ),
                          Text(
                            '1',
                            style: TextStyle(fontSize: 14),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.black,
                            height: 16,
                            width: 1,
                          ),
                          Text(
                            'May 2, 24',
                            style: TextStyle(fontSize: 14),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.black,
                            height: 16,
                            width: 1,
                          ),
                          Text(
                            '05:54PM',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: Image.asset(
                  'assets/tree.jpg', // Replace with your actual asset path
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
