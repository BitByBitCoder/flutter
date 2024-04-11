import 'package:flutter/material.dart';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class TestT extends StatefulWidget {
  const TestT({super.key});

  @override
  State<TestT> createState() => _TestTState();
}

class _TestTState extends State<TestT> {
  final scrollController = ScrollController();
  bool isloading = false;
  List p = [];
  int _itemStartFrom = 0;

  Future fetchP() async {
    if (isloading) return;

    isloading = true;

    String url =
        'https://jsonplaceholder.typicode.com/posts?_start=${_itemStartFrom * 20}&_limit=20';

    try {
      final response = await http.get(Uri.parse(url));
      final result = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('${2 * _itemStartFrom}');
        p.addAll(result);
        _itemStartFrom++;
        setState(() {
          isloading = false;
        });
      } else {
        print('not connected to internet');
        throw Exception('not connected to interned');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isloading = false;
    }
  }

  @override
  void initState() {
    fetchP();
    // TODO: implement initState
    scrollController.addListener(_infiniteScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: p.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                controller: scrollController,
                itemCount: p.length + 1,
                itemBuilder: (context, index) {
                  if (index == p.length) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListTile(
                    leading: Text('${index + 1}'),
                  );
                }));
  }

  void _infiniteScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isloading) {
      fetchP();
      print('bottom');
    }
  }
}
