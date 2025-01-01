import 'package:d_report/src/core/helpers/helpers.dart';
import 'package:d_report/src/feature/find_patient/domain/entities/patient.dart';
import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';

class CaseTile extends StatelessWidget {

  final context;
  final SearchPatient dataPatientRow;
  final AuthUser authUser;
  final User user;

  const CaseTile(this.context, this.dataPatientRow, this.authUser, this.user, {super.key});

  @override
  Widget build(BuildContext context) {

    IconData gender;

    switch(dataPatientRow.patGender) {
      case 'Male':
        gender = Icons.male;
        break;
      case 'Female':
        gender = Icons.female;
        break;
      default:
        gender = Icons.circle_outlined;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 3),
      child: ListTile(
        title: Text(
          '${dataPatientRow.patName} ${dataPatientRow.patLastName}',
          style: Theme.of(context).listTileTheme.titleTextStyle,
        ),
        subtitle: Text(
          'CI Representante: ${dataPatientRow.patGuardianDni}\nEdad: ${Helper.getAgeByDateInString(dataPatientRow.patBirthdayDate)}',
          style: Theme.of(context).listTileTheme.subtitleTextStyle,
        ),
        leading: const SizedBox(
          height: double.maxFinite,
          width: 5,
        ),
        tileColor: dataPatientRow.patIsSelected ? Colors.blue : Theme.of(context).listTileTheme.tileColor,
        trailing: Icon(gender),
        //onTap: () {
          /*final result = await Navigator.of(context).pushNamed('/main/patients/details/',
              arguments: {
                "casKey": int.parse(dataPatientRow.casId),
                'patFullName': dataPatientRow.patName,
                'AuthCredentials': authUser,
                'userData': user
              });
          if (result == true) {
            context.read<MyCasesCubit>().refreshCases(user.userProfileId, authUser.accessToken);
          }*/
        //},
      ),
    );
  }
}

// TODO ADD DETAILS VIEW
