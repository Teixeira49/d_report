import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class CaseDataTextArea extends StatefulWidget {
  const CaseDataTextArea(
      {super.key, required this.contextRow, required this.controllerData});

  final String contextRow;
  final TextEditingController controllerData;

  @override
  MyCaseDataTextAreaWidget createState() => MyCaseDataTextAreaWidget();
}

class MyCaseDataTextAreaWidget extends State<CaseDataTextArea> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controllerData,
      style: Theme.of(context).textTheme.labelLarge,
      obscureText: obscureTextDefault,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        filled: Theme.of(context).inputDecorationTheme.filled,
        border: Theme.of(context).inputDecorationTheme.border,
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
