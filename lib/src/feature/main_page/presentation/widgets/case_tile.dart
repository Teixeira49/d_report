import 'dart:ui';

import 'package:d_report/src/feature/main_page/domain/entities/patient.dart';
import 'package:flutter/material.dart';

class CaseTile extends StatelessWidget {

  final context;
  final Patient dataPatient;

  const CaseTile(this.context, this.dataPatient, {super.key});

  @override
  Widget build(BuildContext context) {

    // TODO REFACTOR
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 1.5,
        horizontal: 3
      ),
      child: ListTile(
        title: Text(
          dataPatient.getAllName(),
          style: Theme.of(context).listTileTheme.titleTextStyle,
        ),
        subtitle: Text(
          dataPatient.getMessage(),
          style: Theme.of(context).listTileTheme.subtitleTextStyle,
        ),
        trailing: const Icon(
          Icons.arrow_circle_right, color: Colors.grey, // TODO delete Colors
        ),
        leading: const SizedBox(
          height: double.maxFinite,
          width: 5,
        ),
        onTap: () {
          Navigator.of(context).pushNamed('/main/patients/details/',
              arguments: {"data":dataPatient}
          );
        },
      ),
    )
      ;
  }
}