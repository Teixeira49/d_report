import 'package:flutter/material.dart';

class ButtonTile extends StatelessWidget {
  const ButtonTile(
      {super.key,
      required this.titleOptionText,
      required this.descOptionText,
      required this.iconData,
      required this.route,
      this.getIndex,
      required this.arguments});

  final String titleOptionText;
  final String descOptionText;
  final IconData iconData;
  final String route;
  final dynamic arguments;
  final int? getIndex;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ListTile(
          title: Text(titleOptionText),
          subtitle: Text(descOptionText),
          leading: Container(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(iconData),
          ),
          onTap: () {

            arguments['title'] = titleOptionText;
            if (getIndex != null) {
              arguments['id'] = getIndex;
              print(getIndex);
            }

            Navigator.of(context).pushNamed(
                '/main/patients/details/edit-case/$route',
                arguments: arguments);
          },
        ),
        const Divider()
      ],
    );
  }
}
