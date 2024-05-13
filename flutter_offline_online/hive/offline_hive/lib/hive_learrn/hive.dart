import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:offline_hive/hive_learrn/controller.dart';
import 'package:offline_hive/hive_learrn/model.dart';
import 'package:offline_hive/hive_learrn/view.dart';

class HiveScreen extends ConsumerWidget {
  HiveScreen({super.key});

  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(hiveControllerProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ShowDataList()));
              },
              icon: Icon(Icons.circle))
        ],
      ),
      body: Column(
        children: [
          Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter age';
                      }
                      return null;
                    },
                  ),
                  Radio(
                      value: true,
                      groupValue: data.married,
                      onChanged: (vale) {
                        ref
                            .read(hiveControllerProvider.notifier)
                            .updateMarried(true);
                      }),
                  Radio(
                    value: false,
                    groupValue: data.married,
                    onChanged: (vale) {
                      ref
                          .read(hiveControllerProvider.notifier)
                          .updateMarried(false);
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate() &&
                          data.married != null) {
                        ref
                            .read(hiveControllerProvider.notifier)
                            .updateName(_nameController.text.trim());
                        ref.read(hiveControllerProvider.notifier).updateAge(
                            int.tryParse(_ageController.text.trim()));

                        // Store the updated state in Hive
                        await ref
                            .read(hiveControllerProvider.notifier)
                            .storeData();

                        print('Data submitted and stored');
                      } else {
                        print('Please enter all fields');
                      }
                    },
                    child: Text('Submit'),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
