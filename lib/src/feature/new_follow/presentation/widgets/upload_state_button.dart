import 'package:d_report/src/feature/new_follow/presentation/cubit/upload_follow/upload_follow_cubit.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadButton extends StatelessWidget {
  const UploadButton(
      {super.key,
        required this.selected,
        required this.size,
        required this.endEdit});

  final int selected;
  final Size size;
  final VoidCallback endEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 50,), // TODO CREATE A CONSTANT
        width: size.width * 0.50,
        height: size.height / 18,
        child: MaterialButton(
          color: selected != -1
              ? Theme.of(context).colorScheme.primary
              : Colors.blueGrey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
          elevation: 10,
          focusColor: Theme.of(context).colorScheme.inversePrimary,
          child: Text(
            continueRegister,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge?.color,
                fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
                fontSize: 20),
          ),
          onPressed: () {
            endEdit();
            //context
            //    .read<UploadFollowCubit>()
            //    .postUploadFollowData(data, accessToken);
            //Navigator.of(context).pushNamed(
            //  '/main/new-case/add-case',
            //);
          },
        ));
  }
}
