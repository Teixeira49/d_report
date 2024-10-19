import 'dart:ui';

import 'package:d_report/src/feature/main_page/domain/entities/patient.dart';
import 'package:flutter/material.dart';

class CaseTile extends StatelessWidget {

  final context;
  final Patient dataPatient;

  const CaseTile(this.context, this.dataPatient, {super.key});

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Text(
        dataPatient.getAllName(),
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      subtitle: Text(
        dataPatient.getMessage(),
        style: Theme.of(context).listTileTheme.subtitleTextStyle,
      ),
      tileColor: Theme.of(context).listTileTheme.tileColor,
      shape: Theme.of(context).listTileTheme.shape,
      trailing: const Icon(
        Icons.arrow_circle_right, color: Colors.grey, // TODO delete Colors
      ),
      leading: const Icon(
        Icons.person_search_outlined, color: Colors.grey,
      ),
      onTap: () {
        Navigator.of(context).pushNamed('/main/patients/details/',
            arguments: {"data":dataPatient}
        );
      },
    );
  }
}