import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class CaseDataTextField extends StatefulWidget {

  const CaseDataTextField({super.key, required this.contextRow, required this.controllerData, required this.textInputType,});

  final String contextRow;
  final TextEditingController controllerData;
  final TextInputType textInputType;

  @override
  MyCaseDataTextFieldWidget createState() => MyCaseDataTextFieldWidget();
}

  class MyCaseDataTextFieldWidget extends State<CaseDataTextField> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: TextFormField(
          controller: widget.controllerData,
          style: Theme.of(context).textTheme.labelLarge,
          obscureText: obscureTextDefault,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            filled: Theme.of(context).inputDecorationTheme.filled,
            border: Theme.of(context).inputDecorationTheme.border,
            labelText: widget.contextRow,
            labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
            hintText: hintEditProfile,
            hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
          ),
        ),
    );
  }
}