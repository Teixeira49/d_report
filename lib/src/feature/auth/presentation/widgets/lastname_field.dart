import 'package:flutter/material.dart';

class LastNameTextField extends StatelessWidget {
  const LastNameTextField({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: TextFormField(
          //controller: ,
          obscureText: false,
          keyboardType: TextInputType.name,
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
            labelText: 'Last Name *',
            labelStyle: TextStyle(
              color: Color.fromRGBO(58, 58, 58, 1.0),
              fontWeight: FontWeight.w700,
            ),
            hintText: 'What do people call you?',
          ),
          onSaved: (String? value) {
            debugPrint(
                'Value for field name saved as "$value"'); // TODO delete in other moment
          },
          validator: (String? value) {
            return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
          },
        ),
    );
  }
}