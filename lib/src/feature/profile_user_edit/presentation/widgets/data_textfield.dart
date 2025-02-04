import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';
import 'package:flutter/services.dart';

class DataTextField extends StatefulWidget {
  const DataTextField(
      {super.key,
      required this.contextRow,
      required this.typeData,
      required this.iconData,
      required this.controller,
      this.inputFormatters});

  final TextInputType typeData;
  final String contextRow;
  final IconData iconData;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;

  @override
  MyDataTextFieldWidget createState() => MyDataTextFieldWidget();
}

class MyDataTextFieldWidget extends State<DataTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: widget.controller,
        style: Theme.of(context).textTheme.labelLarge,
        obscureText: obscureTextDefault,
        keyboardType: widget.typeData,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          filled: Theme.of(context).inputDecorationTheme.filled,
          border: Theme.of(context).inputDecorationTheme.border,
          suffixIcon: Icon(
            widget.iconData,
            color: Theme.of(context).iconTheme.color,
          ),
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
          return (value != null && value.contains('@'))
              ? 'Do not use the @ char.'
              : null;
        },
      ),
    );
  }
}

//IconButton(
//               icon: isEnabled ? const Icon(Icons.check) : const Icon(Icons.edit),
//               color: Theme.of(context).iconTheme.color,
//               onPressed: () {
//                 setState(() {
//                   isEnabled = !isEnabled;
//                 });
//                 print("SetSTATE");
//                 print(isEnabled);
//               },
//             ),
