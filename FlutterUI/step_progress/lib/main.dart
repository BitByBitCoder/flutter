import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('hello'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(50, 24, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: Stack(
                            children: [
                              Container(
                                width: 12,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 73, 60),
                                  shape: BoxShape.circle,
                                ),
                                alignment: AlignmentDirectional(0, -1),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 45, 139, 122),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('Chawhma'),
                          Container(
                            width: 200,
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Zirtirt:'),
                              Text('Hruaia'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Zirlai:'),
                              Text('Ramthar'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: Stack(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 117, 118, 118),
                                  shape: BoxShape.circle,
                                ),
                                alignment: AlignmentDirectional(0, -1),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 1,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 30, 150, 102),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
