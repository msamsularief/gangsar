import 'package:flutter/material.dart';

class FlashBar {
  static void showError(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        backgroundColor: backgroundColor ?? Color(0xFFFF4E4B),
        duration: duration ?? Duration(seconds: 2),
      ),
    );
  }

  static void showOnSucess(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        backgroundColor: backgroundColor ?? Color.fromARGB(255, 68, 255, 102),
        duration: duration ?? Duration(seconds: 2),
      ),
    );
  }
}
