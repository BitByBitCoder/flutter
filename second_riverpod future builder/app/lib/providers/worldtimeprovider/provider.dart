import 'package:app/providers/worldtimeprovider/api_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final worldTimeRepository = Provider((ref) => WorldTimeRepository());

final futureWorldTime = FutureProvider((ref) {
  return ref.watch(worldTimeRepository).fetchWorldTime();
});
