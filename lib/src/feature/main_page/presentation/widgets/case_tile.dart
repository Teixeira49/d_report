import 'package:d_report/src/feature/main_page/domain/entities/case_simple.dart';
import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';

class CaseTile extends StatelessWidget {
  final context;
  final CaseSimple dataPatientRow;
  final AuthUser authUser;
  final User user;

  const CaseTile(this.context, this.dataPatientRow, this.authUser, this.user,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
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
        /*trailing: const Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(Icons.calendar_month,),
            SizedBox(width: 4,),
            Text('Dia: 1'),
        ],),*/
        onTap: () {
          Navigator.of(context)
              .pushNamed('/main/patients/details/', arguments: {
            "casKey": int.parse(dataPatientRow.casId),
            'patFullName': dataPatientRow.patName,
            'AuthCredentials': authUser,
            'userData': user
          });
        },
      ),
    );
  }
}
