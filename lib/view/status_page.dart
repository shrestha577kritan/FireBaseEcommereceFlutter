import 'package:ecommereceshop/view/home_page.dart';
import 'package:ecommereceshop/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/user/user_notifier.dart';

class StatusPage extends ConsumerWidget {
 

  @override
  Widget build(BuildContext context, ref) {
     final userData = ref.watch(userNotifierProvider);
    return Scaffold(
      body: userData.user.isEmpty ? LoginPage() : HomePage(),
    );
  }
}
