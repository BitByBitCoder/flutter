import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/loading.dart';
import 'package:testapp/model.dart/comment_model.dart';

final repositoryCommentProvider = Provider((ref) {
  return CommentRepository();
});

class CommentRepository {
  Future<List<Comment>> fetchRepositoryComments(int page) async {
    try {
      final response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/comments?_page=$page&_limit=20'));

      if (response.statusCode == 200) {
        List result = convert.jsonDecode(response.body);
        return result.map((e) => Comment.fromMap(e)).toList();
      } else {
        throw Exception('cannot fetch data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
