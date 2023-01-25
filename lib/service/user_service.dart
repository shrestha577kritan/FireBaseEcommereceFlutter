import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommereceshop/domain/user/user.dart';
import 'package:ecommereceshop/provider/dioProvider.dart';
import 'package:ecommereceshop/view/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../domain/user/interface_user.dart';
import '../provider/box_provider.dart';

final userServiceProvider = Provider(
    (ref) => UserService(ref.watch(dioProvider), ref.watch(userBoxProvider)));

class UserService implements UserInterface {
  final Box<User> box;
  final Dio dio;
  UserService(this.dio, this.box);

  @override
  Future<Either<String, User>> userLogin(
      {required String email, required String password}) async {
    try {
      final response = await dio.post(Api.userLogin, data: {
        "email": email,
        "password": password,
      });
      final user = User.fromJson(response.data);
      box.add(user);
      return right(user);
    } on DioError catch (err) {
      return left(err.message);
    }
  }

  @override
  Future<Either<String, User>> userSignUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(Api.signup, data: {
        "full_name": username,
        "email": email,
        "password": password,
      });
      final user = User.fromJson(response.data);
      return right(user);
    } on DioError catch (err) {
      return left(err.message);
    }
  }



}
