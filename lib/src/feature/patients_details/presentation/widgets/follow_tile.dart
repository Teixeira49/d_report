import 'dart:ui';

import 'package:d_report/src/feature/main_page/domain/entities/patient.dart';
import 'package:d_report/src/feature/patients_details/domain/entities/follows_in_case.dart';
import 'package:d_report/src/shared/domain/entities/auth_user.dart';
import 'package:flutter/material.dart';

class FollowTile extends StatelessWidget {
  final context;
  final String patFullName;
  final Map<String, dynamic>? patientDetails;
  final FollowCase followData;
  final AuthUser authUser;

  const FollowTile(
      this.context, this.followData, this.patFullName, this.patientDetails, this.authUser,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 3),
      child: ListTile(
        title: Text(
          followData.cafReportTitle.toString(),
          style: Theme.of(context).listTileTheme.titleTextStyle,
        ),
        subtitle: Text(
          followData.cafReportDate,
          style: Theme.of(context).listTileTheme.subtitleTextStyle,
        ),
        leading: const SizedBox(
          height: double.maxFinite,
          width: 5,
        ),
        onTap: () {
          Navigator.of(context)
              .pushNamed('/main/patients/details/follow-case', arguments: {
            "cafId": followData.cafId,
            'patFullName': patFullName,
            'patientDetails': patientDetails,
            'AuthCredentials': authUser,
          });
        },
      ),
    );
  }
}
