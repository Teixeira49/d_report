import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class TypeBloodDropdownField extends StatelessWidget {
  const TypeBloodDropdownField({super.key});
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
            suffixIcon: Icon(
              Icons.water_drop,
              color: Theme.of(context).iconTheme.color,
            ),
            labelText: blood,
            labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
            hintText: hintBlood,
            hintStyle: Theme.of(context).inputDecorationTheme.labelStyle
          ),
          items: bloodType.map((rh){
            return DropdownMenuItem(
                alignment: Alignment.centerLeft,
                value: rh,
                child: Text(
                  rh,
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