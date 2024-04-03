import 'package:flutter/material.dart';

double availableScreenWidth = 0;

class NestedListExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    availableScreenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                // Outer list
                Container(height: 50, child: Text('Outer ListView Item')),

                // Inner horizontal list
                Container(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      // Inner containers
                      Container(
                          width: availableScreenWidth * .90,
                          height: 100,
                          color: Colors.red),
                      Container(width: 100, height: 100, color: Colors.green),
                      Container(width: 100, height: 100, color: Colors.blue),
                      Container(width: 100, height: 100, color: Colors.red),
                      Container(width: 100, height: 100, color: Colors.green),
                      Container(width: 100, height: 100, color: Colors.blue),
                      Container(width: 100, height: 100, color: Colors.red),
                      Container(width: 100, height: 100, color: Colors.green),
                      Container(width: 100, height: 100, color: Colors.blue),
                      Container(width: 100, height: 100, color: Colors.red),
                      Container(width: 100, height: 100, color: Colors.green),
                      Container(width: 100, height: 100, color: Colors.blue),
                    ],
                  ),
                ),

                Container(
                    height: 50, child: Text('Another Outer ListView Item')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
