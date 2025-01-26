import 'package:d_report/my_flutter_app_icons.dart';
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
        subtitle:
            Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.only(top: 6, right: 4),
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.2),
                border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .secondaryContainer
                        .withOpacity(0.3),
                    width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(22))),
            child: Text(
              assignedDoctor.docSpeciality,
              style: Theme.of(context).listTileTheme.subtitleTextStyle,
            ),
          )
        ]),
        tileColor: assignedDoctor.docId == user.userProfileId
            ? Theme.of(context).listTileTheme.tileColor
            : Theme.of(context).colorScheme.onTertiaryContainer,
        leading: Icon(
          MyFlutterApp.user_md,
          size: 22,
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.825),
        ),
        trailing: const Icon(Icons.navigate_next),
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/main/profile/',
              arguments: {
                "userData": user,
                "AuthCredentials": authUser,
                'docId': assignedDoctor.docId
              });
        },
      ),
    );
  }
}
