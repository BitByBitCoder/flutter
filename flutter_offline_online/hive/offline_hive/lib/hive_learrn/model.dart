// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive_generator/hive_generator.dart';
import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class HiveModel extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  int? age;

  @HiveField(2)
  bool? married;
  HiveModel({
    this.name,
    this.age,
    this.married,
  });

  HiveModel copyWith({
    String? name,
    int? age,
    bool? married,
  }) {
    return HiveModel(
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

  factory HiveModel.fromMap(Map<String, dynamic> map) {
    return HiveModel(
      name: map['name'] != null ? map['name'] as String : null,
      age: map['age'] != null ? map['age'] as int : null,
      married: map['married'] != null ? map['married'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HiveModel.fromJson(String source) =>
      HiveModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HiveModel(name: $name, age: $age, married: $married)';

  @override
  bool operator ==(covariant HiveModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age && other.married == married;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ married.hashCode;
}
