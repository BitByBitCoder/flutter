import 'package:app/views/search_product_page.dart';
import 'package:app/views/shopPage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: ProductListPage()));
}
