import 'package:flutter/material.dart';

class ButtonSettingsTileDynamicIcon extends StatelessWidget {


  const ButtonSettingsTileDynamicIcon(
      {super.key,
      required this.titleOptionText,
      required this.route,
        required this.iconLight,
        required this.iconDark,
      this.getIndex,
      required this.arguments});

  final String titleOptionText;
  final String route;
  final IconData iconLight;
  final IconData iconDark;
  final dynamic arguments;
  final int? getIndex;

  @override
  Widget build(BuildContext context) {

    final themeColor = MediaQuery.of(context).platformBrightness.index;

    return Container(
      margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
      child:
        ListTile(
          title: Text(titleOptionText),
          leading: Container(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(themeColor == 1 ? iconLight : iconDark),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios
          ),
          onTap: () {

            Navigator.of(context).pushNamed(
                route,
                arguments: arguments);
          },
        ),
    );
  }
}
