import 'package:flutter/material.dart';

class ButtonSettingsTile extends StatelessWidget {
  const ButtonSettingsTile({
    super.key,
    required this.titleOptionText,
    required this.iconData,
    required this.route,
    this.getIndex,
    required this.arguments
  });

  final String titleOptionText;
  final IconData iconData;
  final String route;
  final int? getIndex;
  final dynamic arguments;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
      decoration: BoxDecoration(
          borderRadius:
          const BorderRadius.all(Radius.circular(20)),
          color: Theme.of(context).listTileTheme.tileColor,
      ),
      child: ListTile(
        title: Text(titleOptionText),
        leading: Container(
          padding: const EdgeInsets.only(right: 4),
          child: Icon(iconData),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          if (getIndex != null) {
            arguments['id'] = getIndex;
          }
          Navigator.of(context).pushNamed(
              route,
              arguments: arguments);
        },
      ),
    );
  }
}
