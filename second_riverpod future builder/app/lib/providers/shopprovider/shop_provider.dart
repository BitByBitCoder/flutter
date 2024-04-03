import 'package:app/providers/shopprovider/api_repo.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final shopRepository = Provider((ref) => ShopRepository());

final futureShop = FutureProvider.autoDispose((ref) {
  return ref.watch(shopRepository).fetchshopporduct();
});

final islightTheme = StateProvider<bool>((ref) => true);
