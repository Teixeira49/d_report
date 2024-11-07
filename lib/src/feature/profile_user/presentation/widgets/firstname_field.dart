import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class FirstNameTextField extends StatefulWidget {

  const FirstNameTextField({super.key, required this.defaultName});

  final String defaultName;

  @override
  MyFirsNameTextFieldWidget createState() => MyFirsNameTextFieldWidget();
}

  class MyFirsNameTextFieldWidget extends State<FirstNameTextField> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: TextFormField(
          style: Theme.of(context).textTheme.labelLarge,
          obscureText: obscureTextDefault,
          initialValue: widget.defaultName,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            filled: Theme.of(context).inputDecorationTheme.filled,
            border: Theme.of(context).inputDecorationTheme.border,
            suffixIcon: const Icon(Icons.person),
            labelText: nameUser,
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