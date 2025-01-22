import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../cubit/new_patient/new_patient_case_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class NextStateButton extends StatelessWidget {
  final String patName;
  final String patLastName;
  final String patGuDni;
  final String patBirthDate;
  final String? patGender;
  final String? patBloodType;
  final String accessToken;
  final Size size;

  const NextStateButton({
    super.key,
    required this.patName,
    required this.patLastName,
    required this.patGuDni,
    required this.patBirthDate,
    required this.patGender,
    required this.patBloodType,
    required this.accessToken,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: size.height / 20),
        width: size.width * 0.50,
        height: size.height * 0.105,
        child: MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
          elevation: 10,
          focusColor: Theme.of(context).colorScheme.inversePrimary,
          child:  Text('Continuar',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleLarge?.color,
                  fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
                  fontSize: 20
              )),
          onPressed: () {
            if (patName.isNotEmpty &&
                patLastName.isNotEmpty &&
                patGuDni.isNotEmpty &&
                patBirthDate.isNotEmpty &&
                patGender != null && patBloodType != null) {
              context.read<CheckPatientCubit>().checkIfPatientExist(
                  patName, patLastName, int.parse(patGuDni), accessToken);
            }
            else {
              FloatingWarningSnackBar.show(context, 'Aun faltan campos de texto por rellenar');
            }
          },
        ));
  }
}
