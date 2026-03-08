import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';

class SnackbarService {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void show({
    required String message,
    Color backgroundColor = AppColors.boxShadowPink,
  }) {
    final messenger = messengerKey.currentState;

    messenger
      ?..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  static void success(String message) =>
      show(message: message, backgroundColor: Colors.green);

  static void error(String message) =>
      show(message: message, backgroundColor: Colors.red);

  static void info(String message) =>
      show(message: message, backgroundColor: Colors.blue);
}
