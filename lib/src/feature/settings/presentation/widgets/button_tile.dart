import 'package:flutter/material.dart';

class ButtonSettingsTile extends StatelessWidget {
  const ButtonSettingsTile({
    super.key,
    required this.titleOptionText,
    required this.iconData,
    this.voidCallback,
  });

  final String titleOptionText;
  final IconData iconData;
  final VoidCallback? voidCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
      child: ListTile(
        title: Text(titleOptionText),
        leading: Container(
          padding: const EdgeInsets.only(right: 4),
          child: Icon(iconData),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          voidCallback;
        },
      ),
    );
  }
}
