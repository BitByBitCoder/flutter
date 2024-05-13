import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  late Future<Box<PersonModels>> _peopleBoxFuture;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    _peopleBoxFuture = Hive.openBox<PersonModels>('people');
    setState(() {
      _isInitialized = true;
    });
  }

  Future<void> _addPerson(Box<PersonModels> box) async {
    final name = _nameController.text;
    final age = int.tryParse(_ageController.text) ?? 0;
    final married = false;

    if (name.isNotEmpty) {
      final person = PersonModels(name: name, age: age, married: married);
      await box.add(person);
      _nameController.clear();
      _ageController.clear();
      setState(() {});
    }
  }

  Future<void> _deletePerson(Box<PersonModels> box, PersonModels person) async {
    await box.delete(person.key);
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
            onPressed: () async {
              final box = await _peopleBoxFuture;
              _addPerson(box);
            },
            child: const Text('Add Person'),
          ),
          Expanded(
            child: FutureBuilder<Box<PersonModels>>(
              future: _peopleBoxFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    final box = snapshot.data!;
                    final people = box.values.toList().cast<PersonModels>();
                    return ListView.builder(
                      itemCount: people.length,
                      itemBuilder: (context, index) {
                        final person = people[index];
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (_) => _deletePerson(box, person),
                          child: ListTile(
                            title: Text(person.name ?? ''),
                            subtitle: Text(
                              'Age: ${person.age ?? 0}, Married: ${person.married ?? false}',
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Error opening Hive box'),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
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
    Hive.close();
    super.dispose();
  }
}
