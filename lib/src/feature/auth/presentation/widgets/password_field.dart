import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {

  const PasswordTextField({super.key, required this.password, required this.controllerData});

  final String password;
  final TextEditingController controllerData;

  @override
  MyPasswordTextFieldWidget createState() => MyPasswordTextFieldWidget();
}

class MyPasswordTextFieldWidget extends State<PasswordTextField> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: widget.controllerData,
        style: Theme.of(context).textTheme.labelLarge,
        obscureText: isObscured,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          filled: Theme.of(context).inputDecorationTheme.filled,
          border: Theme.of(context).inputDecorationTheme.border,
          suffixIcon: IconButton(
            icon: isObscured ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
            color: Theme.of(context).iconTheme.color,
            onPressed: () {
              setState(() {
                isObscured = !isObscured;
              });
            },
          ),
          labelText: widget.password,
          labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
        //onChanged: (value) => {},
      ),
    );
  }
}