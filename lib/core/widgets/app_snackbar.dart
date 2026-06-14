import 'package:flutter/material.dart';

extension AppSnackBar on BuildContext {
  void showAppSnackBar(
    String message, {
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: behavior,
      ),
    );
  }

  void showErrorSnackBar(String message) {
    showAppSnackBar(message, behavior: SnackBarBehavior.floating);
  }
}
