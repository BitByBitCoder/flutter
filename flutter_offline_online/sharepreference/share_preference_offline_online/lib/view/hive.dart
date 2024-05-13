// import 'dart:convert';
import 'package:hive_generator/hive_generator.dart';
import 'package:build_runner/build_runner.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:http/http.dart' as http;

// class OfflineFormSubmission extends StatefulWidget {
//   @override
//   _OfflineFormSubmissionState createState() => _OfflineFormSubmissionState();
// }

// class _OfflineFormSubmissionState extends State<OfflineFormSubmission> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();

//   bool _isOnline = true;

//   @override
//   void initState() {
//     super.initState();
//     _checkInternetConnectivity();
//   }

//   Future<void> _checkInternetConnectivity() async {
//     final connectivity = Connectivity();
//     connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//       setState(() {
//         _isOnline = result != ConnectivityResult.none;
//         if (_isOnline) {
//           _uploadFormDataToServer();
//         }
//       });
//     } as void Function(List<ConnectivityResult> event)?);
//   }

//   Future<void> _saveFormDataLocally() async {
//     final formData = {
//       'name': _nameController.text,
//       'email': _emailController.text,
//     };

//     final box = await Hive.openBox('formData');
//     await box.add(formData);
//   }

//   Future<void> _uploadFormDataToServer() async {
//     final box = await Hive.openBox('formData');
//     final formData = box.values.toList();

//     for (final data in formData) {
//       try {
//         final response = await http.post(
//           Uri.parse('https://your-server.com/forms'),
//           headers: {'Content-Type': 'application/json'},
//           body: jsonEncode(data),
//         );

//         if (response.statusCode == 200) {
//           // Remove the form data from local storage after successful upload
//           await box.deleteAt(formData.indexOf(data));
//         } else {
//           // Handle error uploading form data
//           print('Error uploading form data: ${response.body}');
//         }
//       } catch (e) {
//         // Handle network error
//         print('Network error: $e');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Offline Form Submission'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Name',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _saveFormDataLocally();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Form data saved locally'),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Submit'),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 _isOnline
//                     ? 'You are online'
//                     : 'You are offline. Form data will be uploaded when online.',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';

class TT extends StatefulWidget {
  const TT({super.key});

  @override
  State<TT> createState() => _TTState();
}

class _TTState extends State<TT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('text'),
    );
  }
}
