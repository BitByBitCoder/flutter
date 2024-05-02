import 'package:flutter/material.dart';
import 'package:togglebarshop/testscreen/overlapping.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom TabBar App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Overlapping(),
    );
  }
}

class CustomTabBarScreen extends StatefulWidget {
  @override
  _CustomTabBarScreenState createState() => _CustomTabBarScreenState();
}

class _CustomTabBarScreenState extends State<CustomTabBarScreen> {
  int _selectedIndex = 0;
  final List<String> _tabs = [
    'All',
    'New to you',
    'Music',
    'Browse',
    'Music',
    'Browse'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _tabs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: _selectedIndex == index
                          ? Colors.black87
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        _tabs[index],
                        style: TextStyle(
                          color: _selectedIndex == index
                              ? Colors.white
                              : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                AllScreen(),
                NewToYouScreen(),
                MusicScreen(),
                BrowseScreen(),
                MusicScreen(),
                BrowseScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Screen widgets remain the same

class AllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('All Screen'),
    );
  }
}

class NewToYouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('New to You Screen'),
    );
  }
}

class MusicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Music Screen'),
    );
  }
}

class BrowseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Browse Screen'),
    );
  }
}
