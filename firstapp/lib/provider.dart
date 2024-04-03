import 'package:firstapp/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

final worldTimeRepositoryProvider = Provider((ref) => WorldTimeRepository());

class WorldTimeRepository {
  Future<WorldTime> fetchWorldTime(String location) async {
    final url = 'http://worldtimeapi.org/api/timezone/$location';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WorldTime.fromJson(convert.jsonDecode(response.body));
    } else {
      throw Exception('Failed to get world time');
    }
  }
}

// FutureProvider
final worldTimeProvider = FutureProvider<WorldTime>(
  (ref) async =>
      ref.watch(worldTimeRepositoryProvider).fetchWorldTime('Asia/Kolkata'),
);

// Usage



