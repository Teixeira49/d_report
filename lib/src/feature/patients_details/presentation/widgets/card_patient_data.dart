import 'package:flutter/material.dart';

import 'package:d_report/src/core/config/styles/profile_theme.dart';

class CustomCardPatientRow extends StatefulWidget {

  const CustomCardPatientRow({
    super.key,
    required this.widgetKey,
    required this.widgetValue,
    required this.tileIcon
  });

  final String widgetKey;
  final String widgetValue;
  final IconData tileIcon;

  @override
  MyCustomCardPatientRowWidget createState() => MyCustomCardPatientRowWidget();
}

class MyCustomCardPatientRowWidget extends State<CustomCardPatientRow> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListTile(
        tileColor: Colors.transparent,
        dense: false,
        minLeadingWidth: 5,
        leading: const SizedBox(
          height: double.maxFinite,
          width: 7,
        ),
        title: Text(widget.widgetKey),
        subtitle: Text(widget.widgetValue),
        trailing: Icon(
          widget.tileIcon
        ),
      )
    );
  }
}
