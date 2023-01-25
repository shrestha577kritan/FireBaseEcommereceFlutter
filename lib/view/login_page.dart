import 'package:ecommereceshop/application/user/user_notifier.dart';
import 'package:ecommereceshop/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../common/snack_show.dart';

class LoginPage extends ConsumerWidget {
  final mailController = TextEditingController();
  final passController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(userNotifierProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        SnackShow.ShowSnackBar(context: context,message: next.errorMessage);
      }
    });
    // final mode = ref.watch(validateProvider);
    final auth = ref.watch(userNotifierProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
                      ListTile(
                        leading: Icon(Icons.dark_mode),
                        onTap: () {
                          Get.changeTheme(ThemeData.dark());
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.light_mode),
                        onTap: () {
                          Get.changeTheme(ThemeData.light());
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          'Welcome Back',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      // Container(
                      //   height: 200,
                      //   width: 250,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20)),
                      //   child: Image.asset('assets/images/login.gif'),
                      // ),
                      SizedBox(
                        height: 50.h,
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
                            labelText: 'Email',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(8),
                            )),
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
                            labelText: 'Email',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ElevatedButton(
                          onPressed: auth.isLoad ? null : () {
                            // final m = passController.text
                            //     .trim()
                            //     .replaceAll(RegExp('\\s+'), ' ');
                            _form.currentState!.save();
                            if (_form.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              ref.read(userNotifierProvider.notifier).userLogin(
                                  email: mailController.text.trim(),
                                  password: passController.text.trim()
                              );

                            } else {
                              // ref.read(validateProvider.notifier).toggleState();
                            }
                          },
                          child:
                              // auth.isLoad ? Center(child: CircularProgressIndicator()) :
                              Text('Login')),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          TextButton(
                              onPressed: () {
                                // _form.currentState!.reset();
                                Get.to(() => SignUpPage(),
                                    transition: Transition.leftToRight);
                              },
                              child: Text('Sign Up',
                                  style: TextStyle(fontSize: 22)))
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
