import 'package:flutter/material.dart';

import '../../../../core/utils/constants/fields_constants.dart';

class ConfigFollowAdderSelector extends StatelessWidget {
  const ConfigFollowAdderSelector(
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
      alignment: AlignmentDirectional.center,
      hint: const Text('Seleccione', textAlign: TextAlign.center,),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10), // Reduce el padding vertical
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.blue), // Cambia el color del borde
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.blue),
        ),
        isDense: true,
      ),
        //border: InputBorder.none,),
      items: addCaseFollowType.map((followSelector) {
        return DropdownMenuItem(
            alignment: Alignment.centerLeft,
            value: followSelector,
            child: Text(
              followSelector,
              style: Theme.of(context).inputDecorationTheme.labelStyle,
            ));
      }).toList(),
      onChanged: (newValue) {
        controllerDataDropDown.value = newValue;
      },
      onSaved: (String? value) {},
      isDense: true,
      isExpanded: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Elija una opcion';
        }
        return null;
      },

    );
  }
}
