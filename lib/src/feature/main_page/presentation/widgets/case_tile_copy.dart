import 'package:d_report/src/feature/main_page/domain/entities/case_simple.dart';
import 'package:d_report/src/feature/main_page/presentation/cubit/my_cases/my_cases_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';

class CaseTile extends StatelessWidget {

  final context;
  final CaseSimple dataPatientRow;
  final AuthUser authUser;
  final User user;

  const CaseTile(this.context, this.dataPatientRow, this.authUser, this.user, {super.key});

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
