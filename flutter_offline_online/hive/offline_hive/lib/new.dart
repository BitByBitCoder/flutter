import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:offline_hive/display/display_screen.dart';

class OfflineFormSubmission extends StatefulWidget {
  @override
  _OfflineFormSubmissionState createState() => _OfflineFormSubmissionState();
}

class _OfflineFormSubmissionState extends State<OfflineFormSubmission> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool _isOnline = true;
  StreamSubscription? _connectivitySubscription;
  Timer? _uploadTimer;

  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
    _startUploadTimer();
  }

  Future<void> _checkInternetConnectivity() async {
    final connectivity = await Connectivity().checkConnectivity();
    setState(() {
      _isOnline = connectivity != ConnectivityResult.none;
    });

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty) {
        final result = results.first;
        setState(() {
          _isOnline = result != ConnectivityResult.none;
        });
      }
    });
  }

  Future<void> _saveFormDataLocally() async {
    final formData = {
      'name': _nameController.text,
      'email': _emailController.text,
    };

    final box = await Hive.openBox('formData');

    await box.add(formData);
  }

  Future<void> _uploadLocalData() async {
    final box = await Hive.openBox('formData');
    final formData = box.values.toList();

    if (formData.isNotEmpty && _isOnline) {
      for (final data in formData) {
        try {
          final response = await http.post(
            Uri.parse('https://fakestoreapi.com/products'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          );

          if (response.statusCode == 200) {
            print('upload data success');
            // Remove the form data from local storage after successful upload
            await box.deleteAt(formData.indexOf(data));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('upload data success'),
            ));
          } else {
            // Handle error uploading form data
            print('Error uploading form data: ${response.body}');
          }
        } catch (e) {
          // Handle network error
          print('Network error: $e');
        }
      }
    }
  }

  void _startUploadTimer() {
    _uploadTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      print('1');
      _uploadLocalData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => FormDataListScreen()));
              },
              icon: Icon(Icons.abc))
        ],
        title: Text('Offline Form Submission'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  if (value == null || value.isEmpty) {
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveFormDataLocally();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Form data saved locally'),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 16.0),
              Text(
                _isOnline
                    ? 'You are online'
                    : 'You are offline. Form data will be uploaded when online.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _connectivitySubscription?.cancel();
    _uploadTimer?.cancel();
    super.dispose();
  }
}
