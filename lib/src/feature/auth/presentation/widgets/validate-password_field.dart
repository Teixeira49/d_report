import 'package:flutter/material.dart';

class ValidatePasswordTextField extends StatelessWidget {
  const ValidatePasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: TextField(
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
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
            Icons.lock_rounded,
            color: Color.fromRGBO(58, 58, 58, 1.0),
          ),
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Color.fromRGBO(58, 58, 58, 1.0),
            fontWeight: FontWeight.w700,
          ),
        ),
        //onChanged: (value) => {},
      ),
    );
  }
}