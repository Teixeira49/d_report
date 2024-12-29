import 'package:flutter/material.dart';

class CustomStatusSelector extends StatelessWidget {
  const CustomStatusSelector(
      {super.key,
        required this.controllerDataDropDown, required this.options,});

  final ValueNotifier<String?> controllerDataDropDown;
  final List<String> options;

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
      items: options.map((status) {
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
