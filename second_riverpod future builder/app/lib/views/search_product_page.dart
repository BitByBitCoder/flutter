import 'package:flutter/material.dart';
import 'package:app/component/product_details.dart';
import 'package:app/providers/shopprovider/shop_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/shopprovider/state_notifire_provider.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(futureShop);
    final products = ref.watch(productSearchProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Products'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                  decoration: InputDecoration(hintText: 'Search products...'),
                  onChanged: (text) {
                    ref.read(productProvider.notifier).searchProducts(text);
                  }),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text('\$${product.price}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
