// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  String Name;
  int id;
  List hobby;
  Doc doc;
  User({
    required this.Name,
    required this.id,
    required this.hobby,
    required this.doc,
  });

  User copyWith({
    String? Name,
    int? id,
    List? hobby,
    Doc? doc,
  }) {
    return User(
      Name: Name ?? this.Name,
      id: id ?? this.id,
      hobby: hobby ?? this.hobby,
      doc: doc ?? this.doc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': Name,
      'id': id,
      'hobby': hobby,
      'doc': doc.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      Name: map['Name'] as String,
      id: map['id'] as int,
      hobby: List.from((map['hobby'] as List)),
      doc: Doc.fromMap(map['doc'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(Name: $Name, id: $id, hobby: $hobby, doc: $doc)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.Name == Name &&
        other.id == id &&
        listEquals(other.hobby, hobby) &&
        other.doc == doc;
  }

  @override
  int get hashCode {
    return Name.hashCode ^ id.hashCode ^ hobby.hashCode ^ doc.hashCode;
  }
}

class Doc {
  String addar;
  Doc({
    required this.addar,
  });

  Doc copyWith({
    String? addar,
  }) {
    return Doc(
      addar: addar ?? this.addar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addar': addar,
    };
  }

  factory Doc.fromMap(Map<String, dynamic> map) {
    return Doc(
      addar: map['addar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Doc.fromJson(String source) =>
      Doc.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Doc(addar: $addar)';

  @override
  bool operator ==(covariant Doc other) {
    if (identical(this, other)) return true;

    return other.addar == addar;
  }

  @override
  int get hashCode => addar.hashCode;
}
