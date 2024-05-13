import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:offline_hive/hive_learrn/model.dart';

class ShowDataList extends ConsumerWidget {
  const ShowDataList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storedData = ref.watch(storedDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Stored Data List'),
      ),
      body: ListView.builder(
        itemCount: storedData.length,
        itemBuilder: (context, index) {
          final model = storedData[index];
          return ListTile(
            title: Text('Name: ${model.name}'),
            subtitle: Text('Age: ${model.age}, Married: ${model.married}'),
          );
        },
      ),
    );
  }
}

final storedDataProvider = Provider<List<HiveModel>>((ref) {
  List<HiveModel> storedData = [];

  // Load data from Hive and update storedData
  _loadStoredData().then((value) {
    storedData = value;
  });

  return storedData;
});

Future<List<HiveModel>> _loadStoredData() async {
  try {
    final box = await Hive.openBox<HiveModel>('localdatabase');
    return box.values.toList();
  } catch (e) {
    print('Error retrieving data: $e');
    return [];
  }
}
