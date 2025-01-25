import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../domain/entities/assigned_doctor.dart';

class DoctorCaseTile extends StatelessWidget {
  final AssignedDoctor assignedDoctor;
  final AuthUser authUser;
  final User user;

  const DoctorCaseTile(this.assignedDoctor, this.authUser, this.user,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      child: ListTile(
        title: Text(
          '${assignedDoctor.docName} ${assignedDoctor.docLastName}${assignedDoctor.docId == user.userProfileId ? ' (Yo)' : ''}',
          style: Theme.of(context).listTileTheme.titleTextStyle,
        ),
        subtitle: Text(
          assignedDoctor.docSpeciality,
          style: Theme.of(context).listTileTheme.subtitleTextStyle,
        ),
        tileColor: assignedDoctor.docId == user.userProfileId
            ? Theme.of(context).listTileTheme.tileColor
            : Theme.of(context).colorScheme.onPrimaryContainer,
        leading: const Icon(Icons.local_hospital),
        onTap: () {
          /*Navigator.of(context)
              .pushNamed('/main/patients/details/', arguments: {
            "casKey": int.parse(dataPatientRow.casId),
            'patFullName': dataPatientRow.patName,
            'AuthCredentials': authUser,
            'userData': user
          });*/
        },
      ),
    );
  }
}
