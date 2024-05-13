import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:offline_hive/hive_learrn/model.dart';

final hiveControllerProvider =
    StateNotifierProvider<HiveControlerNotifier, HiveModel>((ref) {
  return HiveControlerNotifier();
});

class HiveControlerNotifier extends StateNotifier<HiveModel> {
  HiveControlerNotifier()
      : super(HiveModel(name: null, age: null, married: null));

  void updateName(String? name) {
    state = state.copyWith(name: name);
  }

  void updateAge(int? age) {
    state = state.copyWith(age: age);
  }

  void updateMarried(bool? isMarried) {
    state = state.copyWith(married: isMarried);
  }

  Future<void> storeData() async {
    try {
      final box = await Hive.openBox<HiveModel>('localdatabase');
      await box.add(state);
      state =
          HiveModel(name: null, age: null, married: null); // Clear the state
      print('Data stored successfully');
    } catch (e) {
      print('Error storing data: $e');
    }
  }
}
