import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class TypeUserDropdownField extends StatelessWidget {
  const TypeUserDropdownField({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: DropdownButtonFormField(
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          decoration: InputDecoration(
            fillColor: Theme.of(context).colorScheme.tertiaryContainer,
            filled: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 0.10,
                style: BorderStyle.none,
                color: Color.fromRGBO(58, 58, 58, 1.0), // TODO Change Theme.of(context).textTheme.headlineSmall?.color
              ),
            ),
            suffixIcon: Icon(
              Icons.person,
              color: Theme.of(context).iconTheme.color,
            ),
            labelText: role,
            labelStyle: TextStyle(
              color: Theme.of(context).textTheme.headlineSmall?.color,
              fontWeight: FontWeight.w700,
            ),
            hintText: hintRole,
            hintStyle: TextStyle(
              color: Theme.of(context).textTheme.headlineSmall?.color,
              fontWeight: FontWeight.w700,
            ),
          ),
          items: userType.map((users){
            return DropdownMenuItem(
                alignment: Alignment.centerLeft,
                value: users,
                child: Text(users)
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