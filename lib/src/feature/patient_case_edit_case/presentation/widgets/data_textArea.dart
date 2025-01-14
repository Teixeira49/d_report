import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class CaseDataTextArea extends StatefulWidget {
  const CaseDataTextArea(
      {super.key, required this.contextRow, required this.controllerData, this.maxLinesHeight});

  final String contextRow;
  final TextEditingController controllerData;
  final int? maxLinesHeight;

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
      maxLines: widget.maxLinesHeight ?? 4,
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
