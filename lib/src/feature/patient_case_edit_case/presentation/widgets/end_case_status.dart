import 'package:flutter/material.dart';

import '../../../../core/utils/constants/fields_constants.dart';

class StatusField extends StatelessWidget {
  const StatusField(
      {super.key,
      required this.controllerDataDropDown,});

  final ValueNotifier<String?> controllerDataDropDown;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: controllerDataDropDown.value,
      style: Theme.of(context).textTheme.labelLarge,
      dropdownColor: Theme.of(context).inputDecorationTheme.fillColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      hint: const Text('Seleccione'),
      decoration: const InputDecoration(
          border: InputBorder.none,),
      items: endCaseType.map((status) {
        return DropdownMenuItem(
            alignment: Alignment.centerLeft,
            value: status,
            child: Text(
              status,
              style: Theme.of(context).inputDecorationTheme.labelStyle,
            ));
      }).toList(),
      onChanged: (newValue) {
        controllerDataDropDown.value = newValue;
      },
      onSaved: (String? value) {},
      isDense: true,
      isExpanded: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Elija una opcion';
        }
        return null;
      },

    );
  }
}
