import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        const SizedBox(
          width: 8,
        )
      ],
    )));
  }
}

class FloatingSnackBar {
  static void show(BuildContext context, String message,
      [IconData? iconData, Color? color]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
      mainAxisAlignment: iconData != null
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (iconData != null)
          Flexible(
              child: Icon(
            iconData,
            color: color,
          )),
        Text(
          message,
          textAlign: TextAlign.center,
        ),
        if (iconData != null)
          const Flexible(
              child: SizedBox(
            width: 8,
          ))
      ],
    )));
  }
}
