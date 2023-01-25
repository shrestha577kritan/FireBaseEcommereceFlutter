import 'package:ecommereceshop/domain/cart_item/cart_item.dart';
import 'package:ecommereceshop/domain/user/user.dart';
import 'package:ecommereceshop/view/introduction_page.dart';
import 'package:ecommereceshop/view/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool show = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  show = prefs.getBool('ON_BOARDING') ?? true;
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CartItemAdapter())
  await Hive.openBox<User>('user');
  await Hive.openBox<User>('carts');

  runApp(ProviderScope(
    child: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 866),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(fontFamily: ''),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: show ? IntroScreen() : StatusPage(),
    );
  }
}

