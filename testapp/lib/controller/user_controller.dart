import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/model.dart/copymodel.dart';

final userControllerProvider =
    StateNotifierProvider<UserController, AsyncValue<User>>((ref) {
  return UserController();
});

class UserController extends StateNotifier<AsyncValue<User>> {
  UserController()
      : super(AsyncValue.data(
            User(Name: '', id: 1, hobby: [], doc: Doc(addar: 'addar')))) {}

  void update(String updated) {
    state = state.whenData((value) => value.copyWith(Name: 'hruaia'));
  }
}
