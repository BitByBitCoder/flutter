import 'dart:async';

import 'package:flutter/material.dart';

class IndexSearchPage extends StatefulWidget {
  @override
  _IndexSearchPageState createState() => _IndexSearchPageState();
}

class _IndexSearchPageState extends State<IndexSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_getSuggestions);
  }

  void _getSuggestions() {
    final query = _searchController.text.toLowerCase();
    final suggestions = [
      'Apple',
      'Banana',
      'Orange',
      'Mango',
      'Pineapple',
    ].where((item) => item.toLowerCase().contains(query)).toList();

    setState(() {
      _suggestions = suggestions..sort((a, b) => a.compareTo(b));
    });
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
            hintText: 'Search...',
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
