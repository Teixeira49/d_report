import 'package:flutter/material.dart';

class FloatingWarningSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
      children: [
        Icon(
          Icons.warning_amber,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const Spacer(),
        Text(
          message,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    )));
  }
}

class FloatingSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        )));
  }
}
