import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';
import 'package:flutter/services.dart';

class PatientDataTextField extends StatefulWidget {

  const PatientDataTextField({super.key, required this.contextRow, required this.controllerData, required this.iconData, this.textInputType, this.inputFormatters});

  final String contextRow;
  final TextEditingController controllerData;
  final IconData iconData;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  MyPatientDataTextFieldWidget createState() => MyPatientDataTextFieldWidget();
}

  class MyPatientDataTextFieldWidget extends State<PatientDataTextField> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: TextFormField(
          controller: widget.controllerData,
          style: Theme.of(context).textTheme.labelLarge,
          obscureText: obscureTextDefault,
          keyboardType: widget.textInputType ?? TextInputType.name ,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            filled: Theme.of(context).inputDecorationTheme.filled,
            border: Theme.of(context).inputDecorationTheme.border,
            suffixIcon: Icon(widget.iconData),
            labelText: widget.contextRow,
            labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
            hintText: hintEditProfile,
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