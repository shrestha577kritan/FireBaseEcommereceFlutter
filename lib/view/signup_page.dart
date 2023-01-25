import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../application/user/user_notifier.dart';
import '../common/snack_show.dart';

class SignUpPage extends ConsumerWidget {
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final passController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(userNotifierProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        SnackShow.ShowSnackBar(context:context,message: next.errorMessage);
      } else if (next.isSuccess) {
        Get.back();
      }
    });
    // final mode = ref.watch(validateProvider);
    final auth = ref.watch(userNotifierProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                          'Join With Us!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22.sp, letterSpacing: 2),
                        ),
                      ),
                      TextFormField(
                        controller: nameController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'please provide name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'username',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        controller: mailController,
                        validator: (val) {
                          // final bool emailValid =
                          // RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          //     .hasMatch(val!);
                          // print(emailValid);
                          if (val!.isEmpty) {
                            return 'please provide email';
                          } else if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(val.trim())) {
                            return 'please provide valid email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Email',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        controller: passController,
                        // inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'please provide password';
                          } else if (val.length > 20) {
                            return 'password character is limit to less than 20';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ElevatedButton(
                          onHover: (value) {
                            Colors.red;
                          },
                          onPressed: auth.isLoad
                              ? null
                              : () {
                                  final m = passController.text
                                      .trim()
                                      .replaceAll(RegExp('\\s+'), ' ');
                                  _form.currentState!.save();
                                  if (_form.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    ref
                                        .read(userNotifierProvider.notifier)
                                        .userSignUp(
                                          email: mailController.text.trim(),
                                          password: passController.text.trim(),
                                          username: nameController.text.trim(),
                                        );

                                    if (auth.isSuccess) {
                                      Get.back();
                                    }
                                  } else {
                                    // ref.read(validateProvider.notifier).toggleState();
                                  }
                                },
                          child:
                              // auth.isLoad ? Center(child: CircularProgressIndicator()) :
                              Text('Sign Up')),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          TextButton(
                              onPressed: () {
                                // _form.currentState!.reset();
                                Get.back();
                              },
                              child:
                                  Text('Login', style: TextStyle(fontSize: 22)))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
