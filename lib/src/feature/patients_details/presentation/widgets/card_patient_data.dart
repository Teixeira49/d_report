import 'package:flutter/material.dart';

class CustomCardPatientRow extends StatefulWidget {
  const CustomCardPatientRow({
    super.key,
    required this.widgetKey,
    required this.widgetValue,
    required this.tileIcon,
    this.sizeIcon,
    this.redirectIcon,
  });

  final String widgetKey;
  final String widgetValue;
  final IconData tileIcon;
  final double? sizeIcon;
  final double? redirectIcon;

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
            subtitle: Text(widget.widgetValue, textAlign: TextAlign.justify,),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
                children: [
              Icon(
                widget.tileIcon,
                size: widget.sizeIcon,
              ),
              widget.redirectIcon != null
                  ? SizedBox(
                      width: widget.redirectIcon,
                    )
                  : Container()
            ])));
  }
}
