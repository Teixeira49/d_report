import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../../../core/utils/constants/fields_constants.dart';
import '../formatter/phone_number_formatter.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({super.key, required this.controllerData, this.iconData, this.contextRow});

  final TextEditingController controllerData;
  final IconData? iconData;
  final String? contextRow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controllerData,
        keyboardType: TextInputType.phone,
        style: Theme.of(context).textTheme.labelLarge,
        obscureText: obscureTextDefault,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          PhoneNumberFormatter(),
        ],
        decoration: InputDecoration(
          hintText: '+58 424 323-8366',
          label: Text(contextRow ?? 'Telefono'),
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          filled: Theme.of(context).inputDecorationTheme.filled,
          border: Theme.of(context).inputDecorationTheme.border,
          suffixIcon: Icon(
            iconData ?? Icons.phone,
            color: Theme.of(context).iconTheme.color,
          ),
          labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
          hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
      ),
    );
  }
}
