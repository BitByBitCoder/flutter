import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:infinite_loading_app/models/postModel.dart';

final postRepositoryProvider =
    Provider<PostRepository>((ref) => PostRepository());

class PostRepository {
  Future<List<Post>> fetchPosts(int page, int limit) async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_start=${page * limit}&_limit=$limit'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
