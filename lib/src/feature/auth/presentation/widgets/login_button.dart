import 'package:d_report/src/feature/auth/presentation/cubit/login_auth_cubit/auth_user_cubit.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {

  const LoginButton({super.key, required this.username, required this.password});

  final String username;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(20.0),
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,

        child: MaterialButton(
          color: Theme
              .of(context)
              .colorScheme
              .primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0)),
          focusColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          child: const Text(
              loadData,
              style: TextStyle(
                  color: Colors.white
              )
          ),
          onPressed: () {
            if (username.isNotEmpty && password.isNotEmpty){
              context.read<AuthCubit>().login(username, password);
            }
          },
        )
    );
  }
}