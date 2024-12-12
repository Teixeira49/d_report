import 'package:flutter/material.dart';

class FloatingWarningSnackBar extends StatelessWidget {
  const FloatingWarningSnackBar({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        content: Row(
          children: [
            Icon(Icons.warning_amber, color: Theme.of(context).colorScheme.secondary,),
            const Spacer(),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        )
    );
  }
}
