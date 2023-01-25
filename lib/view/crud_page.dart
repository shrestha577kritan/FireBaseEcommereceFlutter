import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../service/product_service.dart';
import 'edit_page.dart';

class CrudPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final productData = ref.watch(productProvider);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: productData.when(
              data: (data) {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final product = data[index];
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ListTile(
                        leading: Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          height: 250,
                        ),
                        title: Text(product.product_name),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.to(() => UpdatePage(product),
                                        transition: Transition.leftToRight);
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    // Get.to(()=>RemovePage(product),transition: Transition.leftToRight);
                                    Get.back();
                                  },
                                  icon: Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              error: (err, stack) => Text('$err'),
              loading: () => Center(child: CircularProgressIndicator())),
        ),
      ),
    );
  }
}
