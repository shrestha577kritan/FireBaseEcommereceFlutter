import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../application/product/product_notifier.dart';
import '../common/snack_show.dart';
import '../provider/common_provider.dart';
import '../service/product_service.dart';

class AddPage extends ConsumerWidget {
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  final priceController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
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
                      controller: titleController,
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
                      controller: detailController,
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
                      controller: priceController,
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
                            ? Center(child: Text('please select a image'))
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
                                    Get.defaultDialog(
                                        title: 'pick an image',
                                        content: Text('image is required'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Close')),
                                        ]);
                                  } else {
                                    ref
                                        .read(productNotifierProvider.notifier)
                                        .productAdd(
                                            product_name:
                                                titleController.text.trim(),
                                            product_detail:
                                                detailController.text.trim(),
                                            price: int.parse(
                                                priceController.text.trim()),
                                            image: image);
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
