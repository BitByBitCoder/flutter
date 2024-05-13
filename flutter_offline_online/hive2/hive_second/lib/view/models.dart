// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 1)
class PersonModels extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  int? age;

  @HiveField(2)
  bool? married;
  PersonModels({
    this.name,
    this.age,
    this.married,
  });

  PersonModels copyWith({
    String? name,
    int? age,
    bool? married,
  }) {
    return PersonModels(
      name: name ?? this.name,
      age: age ?? this.age,
      married: married ?? this.married,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'married': married,
    };
  }

  factory PersonModels.fromMap(Map<String, dynamic> map) {
    return PersonModels(
      name: map['name'] != null ? map['name'] as String : null,
      age: map['age'] != null ? map['age'] as int : null,
      married: map['married'] != null ? map['married'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonModels.fromJson(String source) =>
      PersonModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PersonModels(name: $name, age: $age, married: $married)';

  @override
  bool operator ==(covariant PersonModels other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age && other.married == married;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ married.hashCode;
}
