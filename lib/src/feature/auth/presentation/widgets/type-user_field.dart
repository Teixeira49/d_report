import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class TypeUserDropdownField extends StatelessWidget {
  const TypeUserDropdownField({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: DropdownButtonFormField(
          style: Theme.of(context).textTheme.labelLarge,
          dropdownColor: Theme.of(context).inputDecorationTheme.fillColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          decoration: InputDecoration(
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            filled: Theme.of(context).inputDecorationTheme.filled,
            border: Theme.of(context).inputDecorationTheme.border,
            suffixIcon: Icon(
              Icons.person,
              color: Theme.of(context).iconTheme.color,
            ),
            labelText: role,
            labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
            hintText: hintRole,
            hintStyle: Theme.of(context).inputDecorationTheme.labelStyle
          ),
          items: userType.map((users){
            return DropdownMenuItem(
                alignment: Alignment.centerLeft,
                value: users,
                child: Text(
                  users,
                  style: Theme.of(context).inputDecorationTheme.labelStyle,
                )
            );
          }).toList(),
          onChanged: (newValue) {

          },
          onSaved: (String? value) {},
          isDense: true,
          isExpanded: true,
        ),
    );
   }
}