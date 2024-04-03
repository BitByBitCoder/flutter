import 'package:app/providers/shopprovider/product_model.dart';
import 'package:http/http.dart ' as http;
import 'dart:convert' as convert;

class ShopRepository {
  Future<List<Product>> fetchshopporduct() async {
    const url = 'https://fakestoreapi.com/products';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List result = convert.jsonDecode(response.body);
      print(response.body);
      return result.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('cannot fetch');
    }
  }
}
