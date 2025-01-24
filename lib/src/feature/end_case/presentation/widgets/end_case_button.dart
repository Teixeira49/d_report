import 'package:flutter/material.dart';

class EndCaseButton extends StatelessWidget {
  const EndCaseButton({super.key, required this.size, required this.endFunction});

  final Size size;
  final VoidCallback endFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 50,), // TODO CREATE A CONSTANT
        width: size.width * 0.50,
        height: size.height / 18,
        child: MaterialButton(
            color:
            Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(22.0)),
            elevation: 10,
            focusColor: Theme.of(context)
                .colorScheme
                .inversePrimary,
            onPressed: () {
              endFunction();
            },
            child: Text(
              'Finalizar',
              style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.color,
                  fontFamily: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.fontFamily,
                  fontSize: 20),
            )));
  }
}