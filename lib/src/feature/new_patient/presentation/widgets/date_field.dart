import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class DateTextField extends StatefulWidget {

  const DateTextField({super.key});

  @override
  MyDateTextFieldWidget createState() => MyDateTextFieldWidget();
}

class MyDateTextFieldWidget extends State<DateTextField> {

  @override
  Widget build(BuildContext context) {

    TextEditingController _dateController = TextEditingController();

    Future<void> _selectDate() async {
      DateTime? _picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100)
      );

      if (_picked != null) {
        setState(() {
          _dateController.text = _picked.toString().split(" ")[0];
        });
      }
    }

    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: _dateController,
        style: Theme.of(context).textTheme.labelLarge,
        obscureText: obscureTextDefault,
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
        readOnly: true,
        onTap: (){
          _selectDate();
        },
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