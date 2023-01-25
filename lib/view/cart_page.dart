import 'package:ecommereceshop/application/order/order_notifier.dart';
import 'package:ecommereceshop/domain/cart_item/cart_item.dart';
import 'package:ecommereceshop/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home_page.dart';

class CartPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  bool isLoad = false;
  @override
  Widget build(BuildContext context) {
    final totalShow = ref.read(cartProvider.notifier).total;
    final cartState = ref.watch(cartProvider);
    return Scaffold(
      body: cartState.isEmpty
          ? Center(child: Text('Add some product to cart'))
          : ValueListenableBuilder<Box<CartItem>>(
              valueListenable: Hive.box<CartItem>('carts').listenable(),
              builder: (context, box, w) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (c, i) {
                              return SizedBox(
                                height: 15.h,
                              );
                            },
                            itemCount: cartState.length,
                            itemBuilder: (context, index) {
                              final cart = cartState[index];
                              return Row(
                                children: [
                                  Image.network(
                                    cart.imageUrl,
                                    height: 120.h,
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(cart.title),
                                          IconButton(
                                              onPressed: () {
                                                ref
                                                    .read(cartProvider.notifier)
                                                    .removeFromCart(cart);
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ))
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                            'Rs.${cart.price} X ${cart.quantity}'),
                                      ),
                                      Row(
                                        children: [
                                          OutlinedButton(
                                              onPressed: () {
                                                ref
                                                    .read(cartProvider.notifier)
                                                    .singleAddCart(cart);
                                              },
                                              child: Icon(Icons.add)),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: Text('${cart.quantity}'),
                                          ),
                                          OutlinedButton(
                                            onPressed: () {
                                              ref
                                                  .read(cartProvider.notifier)
                                                  .singleRemoveCart(cart);
                                            },
                                            child: Icon(Icons.remove),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('Total'), Text('$totalShow')],
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoad = true;
                                  });
                                  final response =
                                      await ref.read(orderProvider).orderAdd(
                                            amount: totalShow,
                                            dateTime: DateTime.now().toString(),
                                            products: cartState,
                                          );

                                  setState(() {
                                    isLoad = false;
                                  });
                                  if (response == 'success') {
                                    ref.read(cartProvider.notifier).clearCart();
                                    Get.offAll(() => HomePage());
                                  } else {}
                                },
                                child: isLoad
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ))
                                    : Text('Check Out'))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
    );
  }
}
