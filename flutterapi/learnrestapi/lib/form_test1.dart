import 'package:flutter/material.dart';

class FormTest extends StatefulWidget {
  const FormTest({super.key});

  @override
  State<FormTest> createState() => _FormTestState();
}

class _FormTestState extends State<FormTest> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: 'enter your name',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'enter your password',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a passwordf';
                    }
                  },
                ),
                TextButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        print('submitted');
                      }
                    },
                    child: Text('submit'))
              ],
            ),
          ),
        ));
  }
}
