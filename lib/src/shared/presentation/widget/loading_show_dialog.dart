import 'package:flutter/material.dart';
import 'circular_progress_bar.dart';

class LoadingShowDialog {

  static void show(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) =>
            AlertDialog(
              backgroundColor: Theme
                  .of(dialogContext)
                  .scaffoldBackgroundColor,
              content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    const CustomCircularProgressBar(),
                    const SizedBox(height: 18),
                    Text(message, style: Theme
                        .of(dialogContext)
                        .textTheme
                        .titleMedium,),
                  ]
              ),
            ));
  }
}
