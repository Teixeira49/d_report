import 'package:flutter/material.dart';

class CustomSelectButton extends StatelessWidget {
  final int index;
  final String name;
  final int selectIndex;
  final VoidCallback onPressed;

  const CustomSelectButton(
      {super.key,
      required this.index,
      required this.name,
      required this.selectIndex,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: selectIndex == index
            ? Theme.of(context).primaryColor
            : Colors.white,
        child: Container(
            height: 40,
            width: 90,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5.0),
            child: MaterialButton(
              onPressed: onPressed,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: selectIndex == index ? Colors.white : Colors.grey
                ),
              ),
            )));
  }
}
