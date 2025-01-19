import 'package:flutter/material.dart';

class CustomRadioTheme extends StatelessWidget {
  final int isSelectedId;
  final IconData icon;
  final int id;
  final String name;
  final VoidCallback onPressed;

  const CustomRadioTheme(
      {super.key,
      required this.isSelectedId,
      required this.id,
      required this.icon,
      required this.name,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(5.0),
        color: id == isSelectedId ? Colors.blue : Colors.white,
        elevation: 10,
        child: Container(
          height: 150,
          width: 100,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(5.0),
          child: MaterialButton(
              onPressed: onPressed,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    color: id == isSelectedId ? Colors.white : Colors.grey,
                    size: 40,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(
                        color: id == isSelectedId ? Colors.white : Colors.grey),
                  ),
                ],
              )),
        ));
  }
}
