import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class DateTextField extends StatefulWidget {
  const DateTextField(
      {super.key, required this.controllerData, this.selectedDate});

  final TextEditingController controllerData;
  final DateTime? selectedDate;

  @override
  MyDateTextFieldWidget createState() => MyDateTextFieldWidget();
}

class MyDateTextFieldWidget extends State<DateTextField> {

  @override
  void initState() {
    if (widget.selectedDate != null) {
      widget.controllerData.text = widget.selectedDate.toString().split(" ")[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Future<void> selectDate(BuildContext context, DateTime selectedDate) async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100));

      if (picked != null && picked != selectedDate) {
        setState(() {
          print(picked.toString().split(" ")[0]);
          widget.controllerData.text = picked.toString().split(" ")[0];
        });
      }
    }

    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: widget.controllerData,
        style: Theme.of(context).inputDecorationTheme.labelStyle,
        obscureText: obscureTextDefault,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          filled: Theme.of(context).inputDecorationTheme.filled,
          border: Theme.of(context).inputDecorationTheme.border,
          suffixIcon: const Icon(Icons.calendar_month),
          labelText: birthday,
          labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
          hintText: hintBirthday,
          hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
        readOnly: true,
        onTap: () {
          selectDate(context, widget.selectedDate ?? DateTime.now());
        },
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
