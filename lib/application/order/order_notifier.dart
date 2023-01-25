import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommereceshop/exception/exception.dart';
import 'package:ecommereceshop/view/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive/hive.dart';
import '../../domain/cart_item/cart_item.dart';
import '../../domain/order.dart';
import '../../domain/user/user.dart';

final orderProvider = Provider((ref) => OrderNotifier());

final orderHistory = FutureProvider((ref) => OrderNotifier().getOrderHistory());

class OrderNotifier {
  final box = Hive.box<User>('user').values.toList();

  final dio = Dio();
  Future<String> orderAdd({
    required double amount,
    required String dateTime,
    required List<CartItem> products,
  }) async {
    try {
      final response = await dio.post(Api.orderCreate,
          data: {
            'amount': amount,
            'dateTime': dateTime,
            'products': products.map((e) => e.toJson()).toList(),
            'userId': box[0].id
          },
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}',
            },
          ));
      return 'success';
    } on DioError catch (err) {
      throw DioException.getDioError(err);
    }
  }

  Future<List<Order>> getOrderHistory() async {
    try {
      final response = await dio.get('${Api.getOrderHistory}/${box[0].id}',
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}',
            },
          ));
      return (response.data as List).map((e) => Order.formJson(e)).toList();
    } on DioError catch (err) {
      throw DioException.getDioError(err);
    }
  }
}
