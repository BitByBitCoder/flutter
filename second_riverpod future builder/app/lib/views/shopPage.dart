import 'package:app/component/product_details.dart';
import 'package:app/providers/shopprovider/shop_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShopPage extends ConsumerWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(futureShop);
    final isthemeData = ref.watch(islightTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isthemeData ? ThemeData.light() : ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Shop Provider"),
          actions: [
            Switch(
                value: isthemeData,
                onChanged: (value) =>
                    ref.read(islightTheme.notifier).state = value),
            IconButton(
              onPressed: () {
                ref.refresh(futureShop);
              },
              icon: Icon(Icons.abc),
              color: Colors.amber,
            )
          ],
        ),
        body: products.when(
          data: (data) => ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetails(product: data[index])),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                        child: Image.network('${data[index].image}')),
                    title: Text(data[index].title),
                    subtitle: Text('\$${data[index].price}'),
                  ));
            },
          ),
          error: (err, stackTrace) => Text('Error: An error Has accored'),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
