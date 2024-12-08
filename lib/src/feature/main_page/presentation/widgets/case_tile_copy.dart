import 'dart:ui';

import 'package:d_report/src/feature/main_page/domain/entities/case_simple.dart';
import 'package:d_report/src/feature/main_page/domain/entities/patient.dart';
import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/auth_user.dart';

class CaseTile extends StatelessWidget {

  final context;
  final CaseSimple dataPatientRow;
  final AuthUser authUser;

  const CaseTile(this.context, this.dataPatientRow, this.authUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 3),
      child: ListTile(
        title: Text(
          dataPatientRow.patName,
          style: Theme.of(context).listTileTheme.titleTextStyle,
        ),
        subtitle: Text(
          dataPatientRow.casActualRoom,
          style: Theme.of(context).listTileTheme.subtitleTextStyle,
        ),
        leading: const SizedBox(
          height: double.maxFinite,
          width: 5,
        ),
        onTap: () {
          Navigator.of(context).pushNamed('/main/patients/details/',
              arguments: {
                "casKey": int.parse(dataPatientRow.casId),
                'patFullName': dataPatientRow.patName,
                'AuthCredentials': authUser
              });
        },
      ),
    );
  }
}
