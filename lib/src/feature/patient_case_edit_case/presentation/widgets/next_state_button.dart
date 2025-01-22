import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class FetchUpdateButton extends StatelessWidget {
  const FetchUpdateButton(
      {super.key, required this.size, required this.selected, required this.endFindPatient});

  final Size size;
  final int selected;
  final VoidCallback endFindPatient;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: size.height / 20),
        width: size.width * 0.50,
        height: size.height * 0.105,
        child: MaterialButton(
          color: selected != -1 ? Theme
              .of(context)
              .colorScheme
              .primary : Colors.blueGrey,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
          elevation: 10,
          focusColor: Theme.of(context).colorScheme.inversePrimary,
          child: Text(
            continueRegister,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme
                    .of(context)
                    .textTheme
                    .titleLarge
                    ?.color,
                fontFamily: Theme
                    .of(context)
                    .textTheme
                    .titleLarge
                    ?.fontFamily,
                fontSize: 20
            ),
          ),
          onPressed: () {
            if (selected != -1) {
              endFindPatient();
            }
          },
        )
    );
  }
}