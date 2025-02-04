import 'package:d_report/src/feature/main_page/presentation/cubit/my_cases/my_cases_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/styles/static_colors.dart';
import '../../../../core/utils/constants/fields_constants.dart';
import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/bullet.dart';
import '../../domain/entities/case_simple.dart';
import '../../../../shared/presentation/widget/case_tile_badge.dart';

class CaseTile extends StatelessWidget {

  final context;
  final CaseSimple dataPatientRow;
  final AuthUser authUser;
  final User user;

  const CaseTile(this.context, this.dataPatientRow, this.authUser, this.user, {super.key});

  @override
  Widget build(BuildContext context) {

    String title = endCaseTypeMeta[dataPatientRow.casEndReason] ?? 'Error';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      child: ListTile(
        title: Text(
          dataPatientRow.patName,
          style: Theme.of(context).listTileTheme.titleTextStyle,
        ),
        subtitle: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
          BadgeTile(color: ColorPalette.badgeHistory, title: 'Hist. N°: ${dataPatientRow.casId}',),
            !dataPatientRow.casEndFlag
                ? BadgeTile(color: ColorPalette.badgeActualRoom, title: 'Hab: ${dataPatientRow.casActualRoom}')
                  : BadgeTile(color: ColorPalette.selectByEndStatus(dataPatientRow.casEndReason), title: title,)

        ],),
        leading: BulletDecorator(sizeBullet: 9, marginHorizontal: 5,
            marginVertical: 5, gradientSystem: !dataPatientRow.casEndFlag
                ? ColorPalette.activeCase
                : ColorPalette.disabledCase,),
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
