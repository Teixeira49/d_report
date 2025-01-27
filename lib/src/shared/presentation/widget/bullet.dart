import 'package:flutter/material.dart';

class BulletDecorator extends StatelessWidget {
  const BulletDecorator(
      {super.key,
      required this.sizeBullet,
      this.alignment,
      required this.marginHorizontal,
      required this.marginVertical,
      this.gradientSystem,
      this.shadowSystem});

  final double sizeBullet;
  final Alignment? alignment;
  final double marginHorizontal;
  final double marginVertical;
  final List<Color>? gradientSystem;
  final List<BoxShadow>? shadowSystem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeBullet,
      height: sizeBullet,
      alignment: alignment ?? Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: marginHorizontal, vertical: marginVertical),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).textTheme.bodyMedium?.color,
          gradient: (gradientSystem != null) ? LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: gradientSystem!): null,
        boxShadow: (gradientSystem != null) ? shadowSystem : null
      ),
    );
  }
}
