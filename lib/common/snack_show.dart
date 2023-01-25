import 'package:flutter/material.dart';

class SnackShow {
  static ShowSnackBar(
      { required BuildContext context, required String message, SnackBarAction? s}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text(message),
        action: s,
      ),
    );
  }
}
