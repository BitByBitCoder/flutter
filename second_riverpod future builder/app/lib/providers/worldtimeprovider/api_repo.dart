import 'package:app/providers/worldtimeprovider/worldtime_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WorldTimeRepository {
  Future<WorldTimeModel> fetchWorldTime() async {
    const url = 'https://worldtimeapi.org/api/timezone/asia/almaty';
    final response = await http.get(Uri.parse(url));

    Map<String, dynamic> result = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      return WorldTimeModel.fromJson(result);
    } else {
      throw Exception('Failed to get world time');
    }
  }
}
