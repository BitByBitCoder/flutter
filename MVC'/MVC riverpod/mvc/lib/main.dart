import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

// Model
class Product {
  final int id;
  final String title;
  final double price;

  Product({required this.id, required this.title, required this.price});

  factory Product.fromJson(Map json) {
    return Product(
      id: json["id"],
      title: json["title"],
      price: json["price"].toDouble(),
    );
  }
}

// StateNotifierProvider
final productsProvider =
    StateNotifierProvider<ProductsNotifier, AsyncValue<List<Product>>>(
  (ref) => ProductsNotifier(),
);

class ProductsNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  ProductsNotifier() : super(const AsyncValue.loading());

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse("https://fakestoreapi.com/products"));
      final products = jsonDecode(response.body)
          .map<Product>((json) => Product.fromJson(json))
          .toList();
      state = AsyncValue.loaded(products);
    } catch (e) {
      state = AsyncValue.error(e.toString());
    }
  }
}

// View
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);

    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            ElevatedButton(
              onPressed: () =>
                  ref.read(productsProvider.notifier).fetchProducts(),
              child: const Text('Fetch'),
            ),
            const SizedBox(height: 10), // Add spacing for better presentation
            products.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text('Error fetching products: $error'),
              data: (data) => Wrap(
                children: data
                    .map((product) => ListTile(
                          title: Text(product.title),
                          subtitle: Text('\$${product.price}'),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
