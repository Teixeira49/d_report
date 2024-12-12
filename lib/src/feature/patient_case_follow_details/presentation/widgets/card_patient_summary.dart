import 'package:flutter/material.dart';

import 'package:d_report/src/core/config/styles/profile_theme.dart';

class CustomCardResumeRow extends StatefulWidget {

  const CustomCardResumeRow({
    super.key,
    required this.widgetKey,
    required this.widgetValue,
  });

  final String widgetKey;
  final String widgetValue;

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
        leading: const SizedBox(
          height: double.maxFinite,
          width: 7,
        ),
        title: Text(widget.widgetKey),
        subtitle: Text(
          widget.widgetValue,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      )
    );
  }
}
