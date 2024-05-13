import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String _selectedDropdownValue = 'Option 1';
  String _selectedRadioValue = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dropdown'),
            DropdownButtonFormField<String>(
              value: _selectedDropdownValue,
              onChanged: (value) {
                setState(() {
                  _selectedDropdownValue = value!;
                });
              },
              items: ['Option 1', 'Option 2', 'Option 3']
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            Text('Radio Buttons'),
            Row(
              children: [
                Radio(
                  value: 'Male',
                  groupValue: _selectedRadioValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadioValue = value.toString();
                    });
                  },
                ),
                Text('Male'),
                Radio(
                  value: 'Female',
                  groupValue: _selectedRadioValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadioValue = value.toString();
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Print the selected values
                print('Dropdown: $_selectedDropdownValue');
                print('Radio: $_selectedRadioValue');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyForm(),
  ));
}
