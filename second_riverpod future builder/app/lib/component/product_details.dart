import 'package:app/providers/shopprovider/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Center(
          child: Column(
            children: [
              CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  child: Image.network(
                    '${product.image}',
                    height: 300,
                  )),
            ],
          ),
        ));
  }
}
