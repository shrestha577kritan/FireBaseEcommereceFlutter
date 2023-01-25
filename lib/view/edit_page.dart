import 'dart:io';
import 'package:ecommereceshop/common/snack_show.dart';
import 'package:ecommereceshop/domain/product/product.dart';
import 'package:ecommereceshop/provider/common_provider.dart';
import 'package:ecommereceshop/service/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../application/product/product_notifier.dart';

class UpdatePage extends ConsumerStatefulWidget {
  final Product product;
  UpdatePage(this.product);

  @override
  ConsumerState<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends ConsumerState<UpdatePage> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController prodetailController = TextEditingController();
  TextEditingController propriceController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    productNameController..text = widget.product.product_name;
    prodetailController..text = widget.product.product_detail;
    propriceController..text = widget.product.price.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(productNotifierProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        SnackShow.ShowSnackBar(context: context,message: next.errorMessage);
      } else if (next.isSuccess) {
        ref.refresh(productProvider);
        Get.back();
      }
    });
    final crud = ref.watch(productNotifierProvider);
    final image = ref.watch(imageProvider);
    final mode = ref.watch(validateProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              // autovalidateMode: mode,
              key: _form,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 45, top: 10),
                      child: Text(
                        'Create Form',
                        style: TextStyle(fontSize: 22, letterSpacing: 2),
                      ),
                    ),
                    TextFormField(
                      controller: productNameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'please provide title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Title',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: prodetailController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'please provide detail';
                        } else if (val.length > 500) {
                          return 'detail character is limit to less than 20';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Detail',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: prodetailController,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'please provide price';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Price',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            title: 'pick an image',
                            content: Text('Select image option'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    ref
                                        .read(imageProvider.notifier)
                                        .pickImage(true);
                                  },
                                  child: Text('Gallery')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    ref
                                        .read(imageProvider.notifier)
                                        .pickImage(false);
                                  },
                                  child: Text('Camera')),
                            ]);
                      },
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: image == null
                            ? Image.network(widget.product.image)
                            : Image.file(File(image.path)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: crud.isLoad
                            ? null
                            : () {
                                _form.currentState!.save();
                                if (_form.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  if (image == null) {
                                    ref
                                        .read(productNotifierProvider.notifier)
                                        .productUpdate(
                                            product_name: productNameController
                                                .text
                                                .trim(),
                                            product_detail:
                                                prodetailController.text.trim(),
                                            price: int.parse(
                                                propriceController.text.trim()),
                                            productId: widget.product.id);
                                  } else {
                                    ref
                                        .read(productNotifierProvider.notifier)
                                        .productUpdate(
                                            product_name: productNameController
                                                .text
                                                .trim(),
                                            product_detail:
                                                prodetailController.text.trim(),
                                            price: int.parse(
                                                propriceController.text.trim()),
                                            productId: widget.product.id,
                                            image: image,
                                            imageId: widget.product.public_id);
                                  }
                                } else {
                                  ref
                                      .read(validateProvider.notifier)
                                      .toggleState();
                                }
                              },
                        child: crud.isLoad
                            ? Center(child: CircularProgressIndicator())
                            : Text('Submit')),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
