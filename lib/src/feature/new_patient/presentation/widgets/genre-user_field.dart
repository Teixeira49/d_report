import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class TypeGenreDropdownField extends StatelessWidget {
  const TypeGenreDropdownField({super.key});
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
              Icons.person,
              color: Theme.of(context).iconTheme.color,
            ),
            labelText: genre,
            labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
            hintText: hintGenre,
            hintStyle: Theme.of(context).inputDecorationTheme.labelStyle
          ),
          items: genreType.map((users){
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
    );
   }
}