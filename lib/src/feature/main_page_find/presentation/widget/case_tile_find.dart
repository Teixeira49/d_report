import 'package:d_report/src/feature/main_page/presentation/cubit/my_cases/my_cases_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/bullet.dart';
import '../../domain/entities/case_simple.dart';

class CaseTile extends StatelessWidget {

  final context;
  final CaseSimple dataPatientRow;
  final AuthUser authUser;
  final User user;

  const CaseTile(this.context, this.dataPatientRow, this.authUser, this.user, {super.key});

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
          'Historia: ${dataPatientRow.casId}\nHabitacion: ${dataPatientRow.casActualRoom} ',
          style: Theme.of(context).listTileTheme.subtitleTextStyle,
        ),
        leading: BulletDecorator(sizeBullet: 9, marginHorizontal: 5,
            marginVertical: 5, gradientSystem: !dataPatientRow.casEndFlag
                ? [
              Colors.green,
              Colors.lightGreen,
              Colors.lightGreenAccent,
              Colors.limeAccent,
            ]
                : [
              Colors.pink,
              Colors.red,
              Colors.amber,
            ],),
        trailing: const Icon(Icons.navigate_next),
        onTap: () async {
          final result = await Navigator.of(context).pushNamed('/main/patients/details/',
              arguments: {
                "casKey": int.parse(dataPatientRow.casId),
                'patFullName': dataPatientRow.patName,
                'AuthCredentials': authUser,
                'userData': user
              });
          if (result == true) {
            context.read<MyCasesCubit>().refreshCases(user.userProfileId, authUser.accessToken);
          }
        },
      ),
    );
  }
}
