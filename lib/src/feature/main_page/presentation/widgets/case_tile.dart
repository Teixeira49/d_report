import 'package:d_report/src/feature/main_page/domain/entities/case_simple.dart';
import 'package:d_report/src/shared/presentation/widget/bullet.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/styles/static_colors.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/utils/constants/fields_constants.dart';
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
            style: Theme
                .of(context)
                .listTileTheme
                .titleTextStyle,
          ),
          subtitle: Text(
            dataPatientRow.casActualRoom,
            style: Theme
                .of(context)
                .listTileTheme
                .subtitleTextStyle,
          ),
          leading: const SizedBox(
            height: double.maxFinite,
            width: 5,
          ),
          trailing: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [

              Text(!dataPatientRow.casEndFlag
                  ? textFormatterTrailingDays(Helper.countCaseDaysByString(dataPatientRow.casEnterDate))
                  : textFormatterTrailingLabel(dataPatientRow.casEndReason)),
              const SizedBox(width: 4,),
            BulletDecorator(sizeBullet: 9, marginHorizontal: 5,
            marginVertical: 5, gradientSystem: !dataPatientRow.casEndFlag
              ? ColorPalette.activeCase
              : ColorPalette.disabledCase,
          ),
      ],),
    onTap: () {
    Navigator.of(context)
        .pushNamed('/main/patients/details/', arguments: {
    "casKey": int.parse(dataPatientRow.casId),
    'patFullName': dataPatientRow.patName,
    'AuthCredentials': authUser,
    'userData': user
    });
    },
    )
    ,
    );
  }

  static String textFormatterTrailingDays(int days) {
    if (days <= 0) {
      return 'Dia de Ingreso';
    } else if (days == 1) {
      return '$days Dia';
    } else if (days > 999) {
      return '+999 Dias';
    } else {
      return '$days Dias';
    }
  }

  static String textFormatterTrailingLabel(String? endReason) {
    if (endReason == null) {
      return 'Error';
    } else {
      return endCaseTypeMeta[endReason]!;
    }
  }
}
