import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class EntryAreaDropdownField extends StatelessWidget {
  const EntryAreaDropdownField({super.key, required this.controllerData});

  final ValueNotifier<String?> controllerData;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: controllerData.value,
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
          hintStyle: Theme.of(context).inputDecorationTheme.labelStyle),
      items: entryAreaType.map((ea) {
        return DropdownMenuItem(
            alignment: Alignment.centerLeft,
            value: ea,
            child: Text(
              entryAreaTypeMeta[ea]!,
              style: Theme.of(context).inputDecorationTheme.labelStyle,
            ));
      }).toList(),
      onChanged: (newValue) {
        controllerData.value = newValue;
      },
      onSaved: (String? value) {},
      isDense: true,
      isExpanded: true,
    );
  }
}
