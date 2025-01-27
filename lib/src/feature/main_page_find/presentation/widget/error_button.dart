import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorElevatedButton extends StatelessWidget {
  const ErrorElevatedButton(
      {super.key, required this.size, required this.function});

  final Size size;
  final AsyncCallback function;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: size.height / 20),
      width: size.width * 0.40,
      height: size.height * 0.105,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll<double>(7.5),
          shadowColor: MaterialStatePropertyAll<Color>(
              Theme.of(context).colorScheme.shadow),
        ),
        onPressed: () async {
          await function();
          //await context
          //    .read<MyCasesCubit>()
          //    .refreshCases(user.userProfileId, authUser.accessToken);
        },
        child: Text('Reintentar',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
                fontSize: 20)),
      ),
    );
  }
}
