import 'package:ecommereceshop/application/order/order_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final orderData = ref.watch(orderHistory);

    return Scaffold(
      body: SafeArea(
        child: orderData.when(
          data: (data) {
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Image.network(data[index].products[0].imageUrl);
                });
          },
          error: (err, stack) => Text('$err'),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
