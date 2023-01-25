import 'package:ecommereceshop/domain/cart_item/cart_item.dart';

class Order {
  final int amount;
  final String userId;
  final List<CartItem> products;
  final String dateTime;

  Order({
    required this.amount,
    required this.userId,
    required this.products,
    required this.dateTime,
  });

factory Order.formJson(Map<String, dynamic> json){
    return Order(
        amount: json['amount'],
        dateTime: json['dateTime'],
        products: (json['products'] as List).map((e) => CartItem.formJson(e)).toList(),
        userId: json['userId']
    );
  }

  // AIzaSyBnYNy95jc8IS-KjlZmtOA0U67S07sj2pk





}
