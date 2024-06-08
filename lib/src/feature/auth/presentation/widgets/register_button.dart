import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

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
          child: const Text('Load Data', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        )
    );
  }
}