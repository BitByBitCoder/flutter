// To parse this JSON data, do
//
//     final comment = commentFromMap(jsonString);

import 'dart:convert';

class Comment {
  int postId;
  int id;
  String name;
  String email;
  String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  Comment copyWith({
    int? postId,
    int? id,
    String? name,
    String? email,
    String? body,
  }) =>
      Comment(
        postId: postId ?? this.postId,
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        body: body ?? this.body,
      );

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };
}
