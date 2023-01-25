import 'package:ecommereceshop/application/user/user_state.dart';
import 'package:ecommereceshop/service/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/user/user.dart';
import '../../provider/box_provider.dart';

final userNotifierProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) => UserNotifier(
      UserState(
          user: ref.watch(userBoxProvider).values.toList(),
          isLoad: false,
          errorMessage: '',
          isSuccess: false),
      ref.watch(userServiceProvider)),
);

class UserNotifier extends StateNotifier<UserState> {
  final UserService userService;

  UserNotifier(super.state, this.userService);

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(errorMessage: '', isLoad: true);
    final response =
        await userService.userLogin(email: email, password: password);
    response.fold((l) {
      return state = state.copyWith(errorMessage: l, isLoad: false, user: []);
    }, (r) {
      return state = state.copyWith(errorMessage: '', isLoad: false, user: [r]);
    });
  }

  Future<void> userSignUp({
    required String username,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(errorMessage: '', isLoad: true, user: []);

    final response = await userService.userSignUp(
        username: username, email: email, password: password);
    response.fold((l) {
      return state = state.copyWith(errorMessage: l, isLoad: false, user: []);
    }, (r) {
      return state = state.copyWith(
          errorMessage: '', isLoad: true, user: [], isSuccess: true);
    });
  }

  void logOut() {
    Hive.box<User>('user').clear();
    state = state.copyWith(user: []);
  }
}
