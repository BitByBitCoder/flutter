import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'user_model.dart';

class WorldTimeRepository {
  Future<WorldTime> fetchWorldTime(String location) async {
    final url = 'http://worldtimeapi.org/api/timezone/$location';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.body);
      return WorldTime.fromJson(convert.jsonDecode(response.body));
    } else {
      throw Exception('Failed to get world time');
    }
  }
}
