import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:learnrestapi/form_test1.dart';
import 'package:learnrestapi/pagination.dart';
import 'package:learnrestapi/refresh.dart';

class PaginationPage extends StatefulWidget {
  const PaginationPage({super.key});

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends State<PaginationPage> {
  final controller = ScrollController();
  int _limit = 20;
  @override
  void initState() {
    fetchData();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        _limit = _limit + 20;
        print(_limit);
        fetchDataMore(_limit);
      }
    });
    // TODO: implement initState
    super.initState();
  }

  List posts = [];

  Future fetchData() async {
    try {
      String url = 'https://fakestoreapi.com/products?limit=$_limit';
      final response = await http.get(Uri.parse(url));
      List result = convert.jsonDecode(response.body);
      print(result[1]['id']);

      posts = result;
      setState(() {});
    } catch (e) {
      // Return the error to be handled by the FutureBuilder
      print(e);
    }
  }

  Future fetchDataMore(_more) async {
    try {
      String url = 'https://fakestoreapi.com/products?limit=$_more';
      final response = await http.get(Uri.parse(url));
      List result = convert.jsonDecode(response.body);
      print(result[1]['id']);

      posts.addAll(result);
      setState(() {});
    } catch (e) {
      // Return the error to be handled by the FutureBuilder
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: fetchData,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Pagination'),
            ),
            body: posts.isEmpty
                ? Center(
                    child: Text(
                      'loading',
                    ),
                  )
                : ListView.builder(
                    controller: controller,
                    itemCount: posts.length + 1,
                    itemBuilder: (context, index) {
                      if (index < posts.length) {
                        return Text(
                          '$index hello',
                          style: TextStyle(fontSize: 30),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('loading......'),
                        );
                      }
                    })));
  }
}
