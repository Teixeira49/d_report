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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.5)
        ),
        child: ListTile(
          dense: false,
          minLeadingWidth: 7,
          leading: Container(
            height: double.maxFinite,
            width: 7,
          ),
          title: Text(widget.defaultKey),
          subtitle: Text(widget.defaultValue),
          trailing: Icon(
            Icons.person_search_outlined,
              color: Theme.of(context).listTileTheme.iconColor
          ),
        ),
      )
    );
  }
}
