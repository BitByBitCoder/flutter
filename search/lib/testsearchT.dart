import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TestSearch extends StatefulWidget {
  const TestSearch({super.key});

  @override
  State<TestSearch> createState() => _TestSearchState();
}

class _TestSearchState extends State<TestSearch> {
  @override
  void initState() {
    fetchSearch();
    // TODO: implement initState
    super.initState();
  }

  bool _isSearch = false;
  List searchList = [];
  final SearchController = TextEditingController();

  void fetchSearch() async {
    final response = await http.get(Uri.parse(
        'https://en.wikipedia.org/w/api.php?action=opensearch&search=elon&limit=10&format=json&origin=*'));

    final result = convert.jsonDecode(response.body);

    print(result[0].cast);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: SearchController,
            onTap: () {
              setState(() {
                _isSearch = true;
              });
            },
          ),
          _isSearch
              ? Expanded(
                  child: ListView.builder(
                      itemCount: searchList.length,
                      itemBuilder: (contex, index) {
                        return Text('text');
                      }))
              : Text('home')
        ],
      ),
    );
  }
}
