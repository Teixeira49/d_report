import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class UserAccountTextField extends StatelessWidget {
  const UserAccountTextField({super.key, required this.controllerData});

  final TextEditingController controllerData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField (
        controller: controllerData,
        style: Theme.of(context).textTheme.labelLarge,
        obscureText: obscureTextDefault,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          filled: Theme.of(context).inputDecorationTheme.filled,
          border: Theme.of(context).inputDecorationTheme.border,
          suffixIcon: Icon(
              Icons.person,
              color: Theme.of(context).iconTheme.color,
          ),
          labelText: email,
          labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
          hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor complete este campo';
          }
          return null;
        },
        //onChanged: (value) => {},
      ),
    );
  }
}