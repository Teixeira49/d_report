import 'package:d_report/src/feature/new_follow/presentation/cubit/upload_follow/upload_follow_cubit.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({super.key, required this.data, required this.accessToken});

  final Map<String, dynamic> data;
  final String accessToken;

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
            context.read<UploadFollowCubit>().postUploadFollowData(data, accessToken);
            //Navigator.of(context).pushNamed(
            //  '/main/new-case/add-case',
            //);

          },
        )
    );
  }
}