import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class FetchUpdateButton extends StatelessWidget {
  const FetchUpdateButton(
      {super.key,
      required this.size,
      required this.selected,
      required this.endEdit});

  final Size size;
  final int selected;
  final VoidCallback endEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width * 0.50, height: size.height * 0.055,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: MaterialButton(
          color: selected != -1
              ? Theme.of(context).colorScheme.primary
              : Colors.blueGrey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
          elevation: 10,
          focusColor: Theme.of(context).colorScheme.inversePrimary,
          child: Text(
            continueRegister,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge?.color,
                fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
                fontSize: 20),
          ),
          onPressed: () {
            if (selected != -1) {
              endEdit();
            }
          },
        ));
  }
}
