import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class CustomTextField extends StatelessWidget {

  const CustomTextField(this.editTarget, {super.key});

  final String editTarget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        style: Theme.of(context).textTheme.labelLarge,
        obscureText: obscureTextDefault,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          filled: Theme.of(context).inputDecorationTheme.filled,
          border: Theme.of(context).inputDecorationTheme.border,
          suffixIcon: Icon(
            Icons.person,
            color: Theme.of(context).iconTheme.color,
          ),
          labelText: editTarget,
          labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
          hintText: hintNameUser,
          hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
        onSaved: (String? value) {
          debugPrint(
              'Value for field name saved as "$value"'); // TODO delete in other moment
        },
        validator: (String? value) {
          return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
        },
      ),
    );
  }
}