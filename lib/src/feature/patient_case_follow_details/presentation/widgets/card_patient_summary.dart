import 'package:flutter/material.dart';

import 'package:d_report/src/core/config/styles/profile_theme.dart';

class CustomCardResumeRow extends StatefulWidget { // TODO Change for Stateless

  const CustomCardResumeRow({
    super.key,
    required this.widgetKey,
    this.widgetValue,
    this.iconData,
  });

  final String widgetKey;
  final String? widgetValue;
  final IconData? iconData;

  @override
  MyCustomCardResumeRowWidget createState() => MyCustomCardResumeRowWidget();
}

class MyCustomCardResumeRowWidget extends State<CustomCardResumeRow> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListTile(
        tileColor: Colors.transparent,
        dense: false,
        minLeadingWidth: 5,
        leading: (widget.iconData != null) ? Icon(widget.iconData, size: 24,) : null,
        title: Text(widget.widgetKey),
        subtitle: (widget.widgetValue != null) ? Text(
          widget.widgetValue!,
          style: Theme.of(context).textTheme.bodyMedium,
        ) : null,
      )
    );
  }
}
