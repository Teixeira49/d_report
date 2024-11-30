import 'package:flutter/material.dart';

import 'package:d_report/src/core/config/styles/profile_theme.dart';

class CustomCardProfileRow extends StatefulWidget {

  const CustomCardProfileRow({super.key, required this.defaultKey, required this.defaultValue});

  final String defaultKey;
  final String defaultValue;

  @override
  MyCustomCardProfileRowWidget createState() => MyCustomCardProfileRowWidget();
}

class MyCustomCardProfileRowWidget extends State<CustomCardProfileRow> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.5)
        ),
        child: ListTile(
          tileColor: Colors.transparent,
          dense: false,
          minLeadingWidth: 5,
          leading: const SizedBox(
            height: double.maxFinite,
            width: 7,
          ),
          title: Text(widget.defaultKey),
          subtitle: Text(widget.defaultValue),
        ),
      )
    );
  }
}
