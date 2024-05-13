// import 'package:flutter/material.dart';

// class SubmissionForm extends StatefulWidget {
//   @override
//   _SubmissionFormState createState() => _SubmissionFormState();
// }

// class _SubmissionFormState extends State<SubmissionForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _questionGroups = <_QuestionGroupState>[];
//   final _generalCommentsController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('M.A.R.T'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ... (existing code)
//                 TextFormField(
//                   controller: _generalCommentsController,
//                   decoration: InputDecoration(
//                     hintText: 'AWW mizo leh hriathawn dan tihngai zuh nise',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter general comments';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 // ... (existing code)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _printSubmittedData() {
//     final generalComments = _generalCommentsController.text;
//     print('General Comments: $generalComments');

//     for (final questionGroup in _questionGroups) {
//       final selectedOption = questionGroup._selectedOption;
//       if (selectedOption != null) {
//         print('${questionGroup.widget.title}: $selectedOption');
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _generalCommentsController.dispose();
//     super.dispose();
//   }
// }

// // QuestionGroup class remains the same