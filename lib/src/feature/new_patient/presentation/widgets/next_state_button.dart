import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

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

  const NextStateButton({
    super.key,
    required this.patName,
    required this.patLastName,
    required this.patGuDni,
    required this.patBirthDate,
    required this.patGender,
    required this.patBloodType,
    required this.accessToken,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(20.0),
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0)),
          ),
          child: Text(continueRegister,
              style: Theme.of(context).textTheme.titleSmall),
          onPressed: () {
            print("$patName $patLastName $patGuDni $patBirthDate $patGender $patBirthDate $patBloodType");

            if (patName.isNotEmpty &&
                patLastName.isNotEmpty &&
                patGuDni.isNotEmpty &&
                patBirthDate.isNotEmpty &&
                patGender != null && patBloodType != null) {
              context.read<CheckPatientCubit>().checkIfPatientExist(
                  patName, patLastName, int.parse(patGuDni), accessToken);
            }
            else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                  'Aun faltan campos de texto por rellenar',
                  textAlign: TextAlign.center, // TODO Make Global
                ),
                backgroundColor:
                Theme.of(context).appBarTheme.backgroundColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
              ));
            }
          },
        ));
  }
}
