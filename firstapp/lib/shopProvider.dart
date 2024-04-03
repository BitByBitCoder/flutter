import 'package:firstapp/PRODUCT.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert' as convert;
import 'package:firstapp/shopProvider.dart';

import 'package:http/http.dart' as http;

class ShopRepository {
  Future<Iterable<Product>> fetchWorldTime() async {
    final url = 'https://fakestoreapi.com/products';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List result = convert.jsonDecode(response.body);
      print(result);
      final products = result.map((e) => Product.fromJson(e));
      return products;
    } else {
      throw Exception('Failed to get world time');
    }
  }
}

final shopRepositoryProvider = Provider((ref) => ShopRepository());

final shopsProvider = FutureProvider<Iterable<Product>>(
  (ref) async => ref.watch(shopRepositoryProvider).fetchWorldTime(),
);
