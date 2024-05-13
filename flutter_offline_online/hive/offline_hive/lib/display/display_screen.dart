import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FormDataListScreen extends StatefulWidget {
  @override
  _FormDataListScreenState createState() => _FormDataListScreenState();
}

class _FormDataListScreenState extends State<FormDataListScreen> {
  List _formData = [];

  @override
  void initState() {
    super.initState();
    _loadFormData();
  }

  Future<void> _loadFormData() async {
    final formData = await getFormData();
    setState(() {
      _formData = formData;
    });
  }

  Future getFormData() async {
    final box = await Hive.openBox('formData');
    return box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Data List'),
      ),
      body: ListView.builder(
        itemCount: _formData.length,
        itemBuilder: (context, index) {
          final data = _formData[index];
          return ListTile(
            title: Text(data.name),
            subtitle: Text(data.email),
          );
        },
      ),
    );
  }
}
