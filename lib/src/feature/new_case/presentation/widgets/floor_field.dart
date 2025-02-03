import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class FloorMixedField extends StatelessWidget {

  const FloorMixedField({super.key, required this.controllerDataDropDown, required this.controllerDataTextField});

  final ValueNotifier<String?> controllerDataDropDown;
  final TextEditingController controllerDataTextField;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField(
            value: controllerDataDropDown.value,
            style: Theme.of(context).textTheme.labelLarge,
            dropdownColor: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            decoration: InputDecoration(
              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              filled: Theme.of(context).inputDecorationTheme.filled,
              border: Theme.of(context).inputDecorationTheme.border,
              labelText: floor,
              labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
              hintStyle: Theme.of(context).inputDecorationTheme.labelStyle
            ),
            items: floorType.map((rh){
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
              controllerDataDropDown.value = newValue;
          },
          onSaved: (String? value) {},
          isDense: true,
          isExpanded: true,
        )
      ),
      const SizedBox(width: 16),
      Expanded(
       child: TextFormField(
         controller: controllerDataTextField,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        decoration: const InputDecoration(
          hintText: 'Max. 3 números',
        ),
      ),
      ),
    ],
  );
 }
}