import 'package:ecommereceshop/service/product_service.dart';
import 'package:ecommereceshop/view/cart_page.dart';
import 'package:ecommereceshop/view/create_page.dart';
import 'package:ecommereceshop/view/crud_page.dart';
import 'package:ecommereceshop/view/detail_page.dart';
import 'package:ecommereceshop/view/order_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../application/user/user_notifier.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final authData = ref.watch(userNotifierProvider);
    final productData = ref.watch(productProvider);

    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CartPage(), transition: Transition.leftToRight);
              },
              icon: Icon(Icons.shopping_bag_rounded))
        ]),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child: Text(authData.user[0].username)),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(authData.user[0].email),
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add Products'),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.to(() => AddPage(), transition: Transition.leftToRight);
                },
              ),
              ListTile(
                leading: Icon(Icons.create),
                title: Text('Crud page'),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.to(() => CrudPage(), transition: Transition.leftToRight);
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Get.to(() => OrderPage(), transition: Transition.leftToRight);
                },
                leading: Icon(Icons.history),
                title: Text('history'),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('LogOut'),
                onTap: () {
                  Navigator.of(context).pop();
                  Duration(milliseconds: 500);
                  ref.read(userNotifierProvider.notifier).logOut();
                },
              )
            ],
          ),
        ),
        body: Container(
          child: productData.when(
              data: (data) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 4 / 5),
                    itemBuilder: (context, index) {
                      final product = data[index];
                      return InkWell(
                        onTap: () {
                          Get.to(() => DetailPage(product),
                              transition: Transition.leftToRight);
                        },
                        child: GridTile(
                          header: Image.network(
                            product.image,
                            fit: BoxFit.cover,
                            height: 250,
                          ),
                          child: Container(),
                          footer: Container(
                            height: 40,
                            color: Colors.black54,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.product_name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '${product.price}',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              error: (err, stack) => Text('$err'),
              loading: () => Center(child: CircularProgressIndicator())),
        ));
  }
}
