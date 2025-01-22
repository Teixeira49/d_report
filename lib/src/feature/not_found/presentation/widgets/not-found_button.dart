import 'package:flutter/material.dart';

class NotFoundExitButton extends StatelessWidget {
  const NotFoundExitButton({super.key});

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
          elevation: 10,
          focusColor: Colors.red,
          minWidth: 90,
          height: 50,
          child: const Text(
              'Volver al ultimo modulo',
              style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
    );
  }
}