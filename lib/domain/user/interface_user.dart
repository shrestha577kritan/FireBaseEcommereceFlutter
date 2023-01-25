import 'package:dartz/dartz.dart';
import 'package:ecommereceshop/domain/user/user.dart';

abstract class UserInterface {
  Future<Either<String, User>> userLogin({
    required String email,
    required String password,
  });

  Future<Either<String, User>> userSignUp({
    required String username,
    required String email,
    required String password,
  });
}
