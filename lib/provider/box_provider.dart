import 'package:ecommereceshop/domain/cart_item/cart_item.dart';
import 'package:ecommereceshop/domain/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final userBoxProvider = Provider(
  ((ref) => Hive.box<User>('user')),
);

final cartBoxProvider = Provider(
  ((ref) => Hive.box<CartItem>('carts')),
);
