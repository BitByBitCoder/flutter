import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:learnrestapi/form_test1.dart';
import 'package:learnrestapi/pagination.dart';
import 'package:learnrestapi/refresh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaginationPage(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  int page = 0;
  int _limit = 20;
  int num = 1;
  Future fetchData() async {
    try {
      String url = 'https://fakestoreapi.com/products?limit=$num';
      final response = await http.get(Uri.parse(url));
      final result = convert.jsonDecode(response.body);

      return result;
    } catch (e) {
      // Return the error to be handled by the FutureBuilder
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () {
          num = num + 10;
          return fetchData();
        },
        child: Scaffold(
          appBar: AppBar(),
          body: FutureBuilder(
            future: fetchData(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...');
              } else if (snapshot.hasError) {
                // Handle the error
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // Handle the data

                List data = snapshot.data as List<dynamic>;

                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return ListTile(
                        leading: Text('${item['id']}'),
                        title: Text('${item['title']}'),
                      );
                    });
              } else {
                // Default case
                return Text('No data available');
              }
            },
          ),
        ));
  }
}
