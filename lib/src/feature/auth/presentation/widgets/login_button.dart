import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(20.0),
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,

        child: MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0)),
          focusColor: Theme.of(context).colorScheme.inversePrimary,
          child: const Text(loadData, style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pushNamed('/main/patients/');
          },
        )
    );
  }
}