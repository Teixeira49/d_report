
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressBar extends StatelessWidget {

  const CustomCircularProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
      strokeWidth: 4.0,
      strokeAlign: BorderSide.strokeAlignInside,
      color: Theme.of(context).colorScheme.secondary,
    );
  }

}