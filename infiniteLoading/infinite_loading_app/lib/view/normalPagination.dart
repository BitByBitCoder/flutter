import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _posts = [];
  int _currentPage = 0;
  int _itemsPerPage = 20;
  bool _isLoading = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _fetchPosts() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/posts?_start=${_currentPage * _itemsPerPage}&_limit=$_itemsPerPage'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _posts.addAll(data);
          _currentPage++;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      print('fet');
      print('1');
      _fetchPosts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination Example'),
      ),
      body: _posts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _posts.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _posts.length) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return ListTile(
                  leading: Text("${index + 1}"),
                  title: Text(_posts[index]['title']),
                );
              },
            ),
    );
  }
}
