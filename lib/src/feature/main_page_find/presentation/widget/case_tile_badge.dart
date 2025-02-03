

import 'package:flutter/material.dart';

class BadgeTile extends StatelessWidget {

  const BadgeTile({super.key, required this.color, required this.title});

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: const EdgeInsets.only(top: 6, right: 5),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          border: Border.all(
              color: color.withOpacity(0.3),
              width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(22))),
      child: Text(
        title,
        style: Theme.of(context).listTileTheme.subtitleTextStyle,
      ),
    );
  }}
