import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

class NextStateButton extends StatelessWidget {
  const NextStateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(20.0),
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0)
            ),
          ),
          child: Text(
              continueRegister,
              style: Theme.of(context).textTheme.titleSmall
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(
                '/main/new-case/add-case',
            ); // TODO DELETE harcode Argument
          },
        )
    );
  }
}