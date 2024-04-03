import 'package:app/providers/shopprovider/api_repo.dart';
import './product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductProvider extends StateNotifier<List<Product>> {
  ProductProvider() : super([]);

  void searchProducts(String query) async {
    // API request
    final foundProducts = state.where((p) => p.title.contains(query));

    state = foundProducts.toList();
  }
}

final productProvider =
    StateNotifierProvider<ProductProvider, List<Product>>((ref) {
  return ProductProvider();
});

final productSearchProvider =
    StateNotifierProvider<ProductProvider, List<Product>>((ref) {
  return ProductProvider();
});
