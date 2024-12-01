import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class EntryAreaDropdownField extends StatelessWidget {
  const EntryAreaDropdownField({super.key});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
          style: Theme.of(context).textTheme.labelLarge,
          dropdownColor: Theme.of(context).inputDecorationTheme.fillColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          decoration: InputDecoration(
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            filled: Theme.of(context).inputDecorationTheme.filled,
            border: Theme.of(context).inputDecorationTheme.border,
            labelText: entryArea,
            labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
            hintText: hintArea,
            hintStyle: Theme.of(context).inputDecorationTheme.labelStyle
          ),
          items: entryAreaType.map((ea){
            return DropdownMenuItem(
                alignment: Alignment.centerLeft,
                value: ea,
                child: Text(
                  ea,
                  style: Theme.of(context).inputDecorationTheme.labelStyle,
                )
            );
          }).toList(),
          onChanged: (newValue) {

          },
          onSaved: (String? value) {},
          isDense: true,
          isExpanded: true,
    );
   }
}