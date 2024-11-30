import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import '../../../../shared/domain/entities/user.dart';

class FinishRegisterCaseButton extends StatelessWidget {
  const FinishRegisterCaseButton({super.key});

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
          child: Text(
              continueRegister,
              style: Theme.of(context).textTheme.titleSmall
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(
                '/main/patients/',
                arguments: { "userData" : User(userName: "Pepe Loco", userEmail: "Pepeloco@gmail.com", userRole: "Doctor", userImgUrl: "")}
            ); // TODO DELETE harcode Argument
          },
        )
    );
  }
}