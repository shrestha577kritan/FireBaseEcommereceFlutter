import '../../domain/user/user.dart';

class UserState {
  final List<User> user;
  final bool isLoad;
  final String errorMessage;
  final bool isSuccess;

  UserState({
    required this.user,
    required this.isLoad,
    required this.errorMessage,
    required this.isSuccess,
  });

  UserState copyWith({
    List<User>? user,
    bool? isLoad,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return UserState(
        user: user ?? this.user,
        isLoad: isLoad ?? this.isLoad,
        errorMessage: errorMessage ?? this.errorMessage,
        isSuccess: isSuccess ?? this.isSuccess
        );
  }
}
