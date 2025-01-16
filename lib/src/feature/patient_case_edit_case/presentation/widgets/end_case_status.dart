import 'package:flutter/material.dart';

import '../../../../core/utils/constants/fields_constants.dart';

class StatusField extends StatelessWidget {
  const StatusField({
    super.key,
    required this.controllerDataDropDown,
  });

  final ValueNotifier<String?> controllerDataDropDown;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: Text(
            'Estatus de Cierre:',
            style: Theme.of(context).textTheme.labelLarge,
          )),
          Expanded(
              child: DropdownButtonFormField(
            value: controllerDataDropDown.value,
            style: Theme.of(context).textTheme.labelLarge,
            dropdownColor: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            alignment: AlignmentDirectional.center,
            hint: const Text(
              'Seleccione',
              textAlign: TextAlign.center,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
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
          ))
        ],
      ),
    );
  }
}
