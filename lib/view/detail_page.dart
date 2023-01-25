import 'package:ecommereceshop/common/snack_show.dart';
import 'package:ecommereceshop/domain/product/product.dart';
import 'package:ecommereceshop/provider/cart_provider.dart';
import 'package:ecommereceshop/view/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  DetailPage(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Image.network(
              product.image,
              height: 270.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                product.product_name,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.price.toString(),
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  product.product_detail,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Consumer(
              builder: ((context, ref, child) {
                return Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        final response =
                            ref.read(cartProvider.notifier).addToCart(product);
                        SnackShow.ShowSnackBar(
                            context: context,
                            message: response,
                            s: SnackBarAction(
                              label: 'Go To Cart',
                              textColor: Colors.white,
                              onPressed: () {
                                Get.to(() => CartPage(),
                                    transition: Transition.leftToRight);
                              },
                            ));
                      },
                      child: Text(
                        'Add To Cart',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
