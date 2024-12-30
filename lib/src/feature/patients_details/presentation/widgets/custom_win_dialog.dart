import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/assign_utils/assign_utils_cubit.dart';

Future<void> customWindowDialog(BuildContext context,) {

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
              Navigator.of(dialogContext).pop(true);
              //context.read<AssignUtilsCubit>()
              //    .fetchEndAssignDetails(caseId,
              //    user.userProfileId, authUser.accessToken);
            },
            child: const Text('Confirmar'))
      ],
    ),
  );
}