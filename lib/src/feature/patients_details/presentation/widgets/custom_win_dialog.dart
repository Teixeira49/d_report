import 'package:flutter/material.dart';

Future<void> customWindowDialog(BuildContext context, Function function) {

  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) => AlertDialog(
      title: const Text("Advertencia"),
      backgroundColor:
      Theme.of(dialogContext).scaffoldBackgroundColor,
      content: const Text(
        "Al dejar de seguir el caso, ya no saldra en su ventana principal",
        textAlign: TextAlign.justify,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(dialogContext);
          },
          child: Text(
            'Cancelar',
            style: TextStyle(
                color: Theme.of(dialogContext)
                    .colorScheme
                    .secondary),
          ),
        ),
        TextButton(
            onPressed: () {
              function();
              Navigator.of(dialogContext).pop(true);
              Navigator.of(dialogContext).pop(true);
              },
            child: const Text('Confirmar'))
      ],
    ),
  );
}