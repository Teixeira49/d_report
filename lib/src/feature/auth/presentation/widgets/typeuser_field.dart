import 'package:flutter/material.dart';

final List<String> userType = <String>["Doctor","Resident","Administrator"];

class TypeUserDropdownField extends StatelessWidget {
  const TypeUserDropdownField({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
            fillColor: Colors.white70,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 0.10,
                style: BorderStyle.none,
                color: Color.fromRGBO(58, 58, 58, 1.0),
              ),
            ),
            suffixIcon: Icon(
              Icons.person,
              color: Color.fromRGBO(58, 58, 58, 1.0),
            ),
            labelText: 'role',
            labelStyle: TextStyle(
              color: Color.fromRGBO(58, 58, 58, 1.0),
              fontWeight: FontWeight.w700,
            ),
            hintText: 'please, select one role',
            hintStyle: TextStyle(
              color: Color.fromRGBO(58, 58, 58, 1.0),
              fontWeight: FontWeight.w700,
            ),
          ),
          items: userType.map((users){
            return DropdownMenuItem(
              alignment: Alignment.centerLeft,
              value: users,
              child: Text(users)
            );
          }
          ).toList(),
          onChanged: (newValue) {

          },
          onSaved: (String? value) {},
          isDense: true,
          isExpanded: true,
        ),
    );
   }
}