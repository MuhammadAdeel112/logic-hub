import 'package:flutter/material.dart';

class ReuseableSnackbar {
  static void showCustomSnackbar(BuildContext context, String message,
      {int durationInSeconds = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationInSeconds),
      ),
    );
  }
}

// Usage:
// To show a Snackbar, simply call CustomSnackbar.showCustomSnackbar(context, 'Your message here');
