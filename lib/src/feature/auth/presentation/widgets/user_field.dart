import 'package:flutter/material.dart';

class UserAccountTextField extends StatelessWidget {
  const UserAccountTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: TextField(
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
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
              Icons.person,
              color: Color.fromRGBO(58, 58, 58, 1.0),
          ),
          labelText: 'Email',
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