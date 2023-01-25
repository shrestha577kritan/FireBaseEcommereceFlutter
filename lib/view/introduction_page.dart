import 'package:ecommereceshop/view/intropages.dart';
import 'package:ecommereceshop/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecommerece App'),
        centerTitle: true,
      ),
      body: IntroductionScreen(
        pages: pages,
        dotsDecorator: DotsDecorator(
            size: Size(10, 10),
            activeSize: Size.square(15),
            activeColor: Colors.red),
        showDoneButton: true,
        done: Text(
          'Done',
          style: TextStyle(fontSize: 20),
        ),
        showSkipButton: true,
        skip: Text(
          'Skip',
          style: TextStyle(fontSize: 20),
        ),
        showNextButton: true,
        next: Icon(
          Icons.arrow_forward,
          size: 20,
        ),
        onDone: () {
          return onDone(context);
        },
        onSkip: () {
          return onDone(context);
        },
      ),
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => LoginPage()),
      ),
    );
  }
}
