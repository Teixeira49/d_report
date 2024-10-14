import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(20.0),
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,

        child: MaterialButton(
          color: Colors.deepOrange,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0)),
          focusColor: Colors.red,
          child: const Text('Entrance', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/patients/');
          },
        )
    );
  }
}