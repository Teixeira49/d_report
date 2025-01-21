
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressBar extends StatelessWidget {

  const CustomCircularProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        strokeWidth: 5.5,
        strokeAlign: BorderSide.strokeAlignInside,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

}