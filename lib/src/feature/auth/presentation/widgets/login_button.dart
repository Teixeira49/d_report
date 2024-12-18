import 'package:d_report/src/feature/auth/presentation/cubit/login_auth_cubit/auth_user_cubit.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {super.key,
      required this.username,
      required this.password,
      required this.formKey,
      required this.size});

  final Size size;
  final String username;
  final String password;
  final formKey;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: size.height / 20, bottom: 0.4),
        width: size.width * 0.38,
        height: size.height * 0.105,
        child: MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
          //focusColor: Theme.of(context).colorScheme.inversePrimary,
          child: Text(loadData,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge?.color,
                fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
                fontSize: 20
              )),
          onPressed: () {
            if (username.isNotEmpty && password.isNotEmpty) {
              context.read<AuthCubit>().login(username, password);
            } else {
              formKey.currentState?.validate();
            }
          },
        ));
  }
}
