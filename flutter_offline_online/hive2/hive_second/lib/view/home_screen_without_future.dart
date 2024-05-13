import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models.dart';

class HomeScreenSecond extends StatefulWidget {
  const HomeScreenSecond({Key? key}) : super(key: key);

  @override
  State<HomeScreenSecond> createState() => _HomeScreenSecondState();
}

class _HomeScreenSecondState extends State<HomeScreenSecond> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  late Box<PersonModels> _peopleBox;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    _peopleBox = await Hive.openBox<PersonModels>('people');
    setState(() {
      _isInitialized = true;
    });
  }

  void _addPerson() {
    final name = _nameController.text;
    final age = int.tryParse(_ageController.text) ?? 0;
    final married = false;

    if (name.isNotEmpty) {
      final person = PersonModels(name: name, age: age, married: married);
      _peopleBox.add(person);
      _nameController.clear();
      _ageController.clear();
      setState(() {});
    }
  }

  Future<void> _deletePerson(PersonModels person) async {
    await _peopleBox.delete(person.key);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Enter name',
            ),
          ),
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter age',
            ),
          ),
          ElevatedButton(
            onPressed: _addPerson,
            child: const Text('Add Person'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _peopleBox.values.length,
              itemBuilder: (context, index) {
                final person = _peopleBox.getAt(index);
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _deletePerson(person),
                  child: ListTile(
                    title: Text(person!.name ?? ''),
                    subtitle: Text(
                      'Age: ${person.age ?? 0}, Married: ${person.married ?? false}',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _peopleBox.close();
    super.dispose();
  }
}
