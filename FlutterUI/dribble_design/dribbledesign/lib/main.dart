import 'package:dribbledesign/listview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

int selectedIndex = 0;

double availableScreenWidth = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    availableScreenWidth = MediaQuery.of(context).size.width - 50;
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              alignment: Alignment.bottomCenter,
              height: 170,
              decoration: BoxDecoration(color: Colors.blue.shade800),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Riotters',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          'Team Folder',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.10),
                              borderRadius: BorderRadius.circular(10)),
                          child: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.10),
                              borderRadius: BorderRadius.circular(10)),
                          child: IconButton(
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    )
                  ]),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: const TextSpan(
                          text: "Storage",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: "9.1/10GB",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 13)),
                      ])),
                  Text('Upgrade',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue))
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  buildFileSizeChart('SOURCE', Colors.blue, .3),
                  SizedBox(
                    width: 2,
                  ),
                  buildFileSizeChart(
                      'DOC', Color.fromARGB(255, 252, 50, 0), .25),
                  SizedBox(
                    width: 2,
                  ),
                  buildFileSizeChart(
                      'IMAGE', Color.fromARGB(255, 255, 235, 19), .20),
                  SizedBox(
                    width: 2,
                  ),
                  buildFileSizeChart(
                      '', const Color.fromARGB(255, 170, 183, 194), .23),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            const Divider(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Recently updatad',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            buildFileColumn('ff.png', 'desktop', 'sketch'),
                            SizedBox(
                              width: availableScreenWidth * .03,
                            ),
                            buildFileColumn('ff.png', 'mobile', 'sketch'),
                            SizedBox(
                              width: availableScreenWidth * .03,
                            ),
                            buildFileColumn('ff.png', 'interaction', 'sketch'),
                            buildFileColumn('ff.png', 'desktop', 'sketch'),
                            SizedBox(
                              width: availableScreenWidth * .03,
                            ),
                            buildFileColumn('ff.png', 'mobile', 'sketch'),
                            SizedBox(
                              width: availableScreenWidth * .03,
                            ),
                            buildFileColumn('ff.png', 'interaction', 'sketch'),
                          ],
                        ),
                      ),
                      Divider(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Projects',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Create New',
                            style: TextStyle(
                                color: Color.fromARGB(255, 25, 121, 255),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildProjectRow('Project1'),
                      SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildProjectRow('haudi1'),
                      SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildProjectRow('Pakhatna1'),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(color: Colors.white, spreadRadius: 7, blurRadius: 1)
          ]),
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 45, 118, 207),
            shape: CircleBorder(),
            onPressed: () {},
            child: Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (selectedIndex) {},
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.access_time), label: 'Time'),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_time), label: 'Folder'),
          ],
        ),
      ),
    );
  }

  Container buildProjectRow(String fileName) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.folder,
                color: Colors.blue,
              ),
              Text(
                fileName,
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
        ],
      ),
    );
  }

  Column buildFileColumn(String image, String filename, String extention) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(20),
          height: 110,
          width: availableScreenWidth * .31,
          child: Image.asset('assets/images/$image'),
        ),
        SizedBox(
          height: 15,
        ),
        RichText(
          text: TextSpan(
              text: filename,
              style: TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(
                    text: '$extention',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: 12))
              ]),
        )
      ],
    );
  }

  Column buildFileSizeChart(String title, Color color, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 4,
          width: availableScreenWidth * width,
          decoration: BoxDecoration(color: color),
        ),
        SizedBox(
          height: 10,
        ),
        Text('$title')
      ],
    );
  }
}
