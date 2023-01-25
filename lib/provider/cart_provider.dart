import 'package:ecommereceshop/domain/cart_item/cart_item.dart';
import 'package:ecommereceshop/domain/product/product.dart';
import 'package:ecommereceshop/provider/box_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final cartProvider = StateNotifierProvider<CartProvider, List<CartItem>>(
  (ref) => CartProvider(
    ref.watch(cartBoxProvider).values.toList(),
    ref.watch(cartBoxProvider),
  ),
);

class CartProvider extends StateNotifier<List<CartItem>> {
  final Box<CartItem> box;

  CartProvider(super.state, this.box);

  String addToCart(Product product) {
    if (state.isEmpty) {
      final newCartItem = CartItem(
          title: product.product_name,
          id: product.id,
          imageUrl: product.image,
          price: product.price,
          quantity: 1,
          total: product.price);

      box.add(newCartItem);
      state = [newCartItem];
      return 'Successfully added to cart';
    } else {
      final isThere = state.firstWhere(
        (element) => element.id == product.id,
        orElse: (() => CartItem(
            title: 'no',
            id: '',
            imageUrl: '',
            price: 0,
            quantity: 0,
            total: 0)),
      );
      if (isThere.title == 'no') {
        final newCartItem = CartItem(
            title: product.product_name,
            id: product.id,
            imageUrl: product.image,
            price: product.price,
            quantity: 1,
            total: product.price);

        box.add(newCartItem);
        state = [...state, newCartItem];

        return 'Successfully added to cart';
      } else {
        return 'already added to cart';
      }
    }
  }

  void removeFromCart(CartItem cartItem) {
    cartItem.delete();
    state.remove(cartItem);
    state = [...state];
  }

  void singleAddCart(CartItem cartItem) {
    cartItem.quantity += 1;
    cartItem.save();
    state = [
      for (final cart in state)
        if (cart == cartItem) cartItem else cart
    ];
  }

  void singleRemoveCart(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity -= 1;
      cartItem.save();
      state = [
        for (final cart in state)
          if (cart == cartItem) cartItem else cart
      ];
    }
  }

  double get total {
    double total = 0;
    for (final cart in state) {
      total += cart.quantity * cart.price;
    }
    return total;
  }

  void clearCart() {
    box.clear();
    state = [];
  }
}
