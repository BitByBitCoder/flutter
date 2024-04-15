import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:convert' as convert;

import 'package:r_pagination/models/comments.dart';

final commentRepositoryProvider = Provider((ref) {
  return CommentRepository();
});

class CommentRepository {
  Future<List<Comment>> fetchComments(int currentPage) async {
    try {
      final response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/comments?_page=1&_limit=20'));

      if (response.statusCode == 200) {
        List result = convert.jsonDecode(response.body);
        print('good fetch');
        return result.map((e) => Comment.fromJson(e)).toList();
      } else {
        throw Exception('error');
      }
    } catch (e) {
      rethrow;
    }
  }
}
