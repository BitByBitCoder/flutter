import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  late Timer _syncTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startSyncTimer();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _syncTimer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _startSyncTimer() {
    _syncTimer = Timer.periodic(Duration(seconds: 3), (_) {
      print('hello');
      _syncLocalData();
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final formData = {
        'name': _nameController.text,
        'email': _emailController.text,
      };

      try {
        final isOnline = await _isOnline();
        if (isOnline) {
          await _uploadDataToServer(formData);
        } else {
          await _storeDataLocally(formData);
        }
      } catch (e) {
        print('Error: $e');
      }

      _nameController.clear();
      _emailController.clear();
    }
  }

  Future<bool> _isOnline() async {
    try {
      final response = await http.get(Uri.parse('https://google.com'));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<void> _uploadDataToServer(Map<String, dynamic> formData) async {
    final url = Uri.parse('https://fakestoreapi.com/carts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(formData),
    );

    if (response.statusCode == 200) {
      print('Form data uploaded successfully');
      _clearLocalData();
    } else {
      print('Error uploading form data: ${response.statusCode}');
    }
  }

  Future<void> _storeDataLocally(Map<String, dynamic> formData) async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getStringList('form_data') ?? [];
    storedData.add(jsonEncode(formData));
    await prefs.setStringList('form_data', storedData);
    print('Form data stored locally');
  }

  Future<void> _syncLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getStringList('form_data') ?? [];

    if (storedData.isNotEmpty) {
      final isOnline = await _isOnline();
      if (isOnline) {
        for (final formDataJson in storedData) {
          final formData = jsonDecode(formDataJson);
          await _uploadDataToServer(formData);
        }
        await _clearLocalData();
        print('Local data synced with server');
      }
    }
  }

  Future<void> _clearLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('form_data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
