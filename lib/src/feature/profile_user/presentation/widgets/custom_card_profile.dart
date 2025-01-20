import 'package:flutter/material.dart';

class CustomCardProfileRow extends StatefulWidget {
  const CustomCardProfileRow(
      {super.key,
      required this.defaultKey,
      required this.defaultValue,
      required this.trailingIcon});

  final String defaultKey;
  final String defaultValue;
  final IconData trailingIcon;

  @override
  MyCustomCardProfileRowWidget createState() => MyCustomCardProfileRowWidget();
}

class MyCustomCardProfileRowWidget extends State<CustomCardProfileRow> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: ListTile(
            tileColor: Colors.transparent,
            dense: false,
            minLeadingWidth: 2,
            leading: const SizedBox(
              height: double.maxFinite,
            ),
            trailing: Icon(widget.trailingIcon),
            title: Text(widget.defaultKey),
            subtitle: Text(widget.defaultValue),
          ),
        ));
  }
}
