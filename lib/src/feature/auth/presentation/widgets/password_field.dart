import 'package:flutter/material.dart';


class PasswordTextField extends StatefulWidget {

  const PasswordTextField({super.key, required this.password});

  final String password;

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
        obscureText: isObscured,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          fillColor: Colors.white70,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              width: 0.10,
              style: BorderStyle.none,
              color: Color.fromRGBO(58, 58, 58, 1.0), //TODO change for Theme.of(context).textTheme.headlineSmall?.color
            ),
          ),
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
          labelStyle: TextStyle(
            color: Theme.of(context).textTheme.headlineSmall?.color,
            fontWeight: FontWeight.w700,
          ),
        ),
        //onChanged: (value) => {},
      ),
    );
  }
}