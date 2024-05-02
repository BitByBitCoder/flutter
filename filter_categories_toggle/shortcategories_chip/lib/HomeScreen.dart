import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<String> filters = const [
    'All',
    'Shoes',
    'Clothing',
    'Accessories'
  ];
  String selectedFilter = 'All';
  List<Map<String, dynamic>> filteredProducts = productList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () => filterProducts(filter),
                    child: Chip(
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[300],
                      label: Text(filter),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ListTile(
                  title: Text(product['title']),
                  subtitle: Text('\$${product['price']}'),
                  trailing: Text(product['category']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void filterProducts(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == 'All') {
        filteredProducts = productList;
      } else {
        filteredProducts = productList
            .where((product) => product['category'] == filter)
            .toList();
      }
    });
  }
}

// Sample product list
List<Map<String, dynamic>> productList = [
  {'title': 'Product 1', 'price': 9.99, 'category': 'Shoes'},
  {'title': 'Product 2', 'price': 14.99, 'category': 'Clothing'},
  {'title': 'Product 3', 'price': 7.99, 'category': 'Accessories'},
  {'title': 'Product 4', 'price': 19.99, 'category': 'Shoes'},
  {'title': 'Product 5', 'price': 24.99, 'category': 'Clothing'},
  {'title': 'Product 6', 'price': 12.99, 'category': 'Accessories'},
  {'title': 'Product 7', 'price': 29.99, 'category': 'Shoes'},
  {'title': 'Product 8', 'price': 17.99, 'category': 'Clothing'},
  {'title': 'Product 9', 'price': 5.99, 'category': 'Accessories'},
];
