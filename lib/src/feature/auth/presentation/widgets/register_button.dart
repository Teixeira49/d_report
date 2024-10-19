import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(20.0),
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        child: MaterialButton(
          color: Theme.of(context).colorScheme.tertiary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0)),
          focusColor: Theme.of(context).colorScheme.secondary,
          child: Text(
              registerData,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiaryContainer
              )
          ),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        )
    );
  }
}