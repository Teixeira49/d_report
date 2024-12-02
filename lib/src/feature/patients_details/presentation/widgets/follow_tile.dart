import 'dart:ui';

import 'package:d_report/src/feature/main_page/domain/entities/patient.dart';
import 'package:flutter/material.dart';

class FollowTile extends StatelessWidget {

  final context;
  final String dataPatient;

  const FollowTile(this.context, this.dataPatient, {super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 1.5,
        horizontal: 3
      ),
      child: ListTile(
        title: Text(
          dataPatient,
          style: Theme.of(context).listTileTheme.titleTextStyle,
        ),
        subtitle: Text(
          dataPatient,
          style: Theme.of(context).listTileTheme.subtitleTextStyle,
        ),
        leading: const SizedBox(
          height: double.maxFinite,
          width: 5,
        ),
        onTap: () {

        },
      ),
    )
      ;
  }
}