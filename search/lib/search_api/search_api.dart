import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BookSearchPage extends StatefulWidget {
  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_getSuggestions);
  }

  Future<void> _getSuggestions() async {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      final response = await http.get(Uri.parse(
          'http://openlibrary.org/search.json?title=$query&limit=10'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final suggestions =
            data['docs'].map<String>((doc) => doc['title'].toString()).toList();
        setState(() {
          _suggestions = suggestions
            ..sort((a, b) =>
                a.compareTo(b) as int); // Cast compareTo result to int
        });
      } else {
        throw Exception('Failed to fetch suggestions');
      }
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onTap: () {
            setState(() {
              _isSearching = true;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search books...',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: _isSearching
          ? _buildSearchList()
          : Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text('Home Screen Content'),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSearchList() {
    return ListView.builder(
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_suggestions[index]),
          onTap: () {
            // Handle suggestion selection
            print('Selected: ${_suggestions[index]}');
            setState(() {
              _isSearching = false;
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
