import 'package:d_report/src/feature/auth/presentation/cubit/login_auth_cubit/auth_user_cubit.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton(
      {super.key,
        required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.015, bottom: 0.4),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.red.withOpacity(0.5); // Color de la sombra cuando se presiona
              }
              return null; // Dejar el color por defecto en otros estados
            },
          ),
          shadowColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.red; // Color de la sombra cuando se presiona
              }
              return null; // Dejar el color por defecto en otros estados
            },
          ),// TODO create theme for this button
        ),
        child: Text(registerData,
            style: TextStyle(
              fontSize: 18, // TODO Dont Hardcode this
                color: Theme.of(context)
                    .colorScheme
                    .tertiary)),
        onPressed: () {
          Navigator.of(context).pushNamed(
              '/auth/register/');
        },
      ),
    );
  }
}