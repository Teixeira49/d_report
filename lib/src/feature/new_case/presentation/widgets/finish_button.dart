import 'package:d_report/src/shared/presentation/widget/floating_snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/helpers.dart';
import '../cubit/new_patient/new_patient_case_cubit.dart';

class FinishRegisterCaseButton extends StatelessWidget {
  const FinishRegisterCaseButton({
    super.key,
    required this.casStatus,
    required this.casMethodOfEntry,
    required this.casAdmissionReason,
    required this.casSymptomatology,
    required this.casPhysicalState,
    required this.casDiagnosis,
    required this.casActualRoom,
    required this.casFloorLevel,
    required this.casEntryArea,
    required this.patData,
    required this.docId,
    required this.accessToken,
    required this.size,
  });

  final int docId;
  final bool casStatus;
  final bool casMethodOfEntry;
  final String casAdmissionReason;
  final String casSymptomatology;
  final String casPhysicalState;
  final String casDiagnosis;
  final String casActualRoom;
  final String casFloorLevel;
  final String casEntryArea;
  final dynamic patData;
  final String accessToken;
  final Size size;

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
          child: Text("Guardar Paciente",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleLarge?.color,
                  fontFamily:
                      Theme.of(context).textTheme.titleLarge?.fontFamily,
                  fontSize: 20)),
          onPressed: () {
            Map<String, dynamic> casData = {
              'casAdmissionReason': Helper.capitalize(casAdmissionReason, false),
              'casSymptomatology': Helper.capitalize(casSymptomatology, false),
              'casPhysicalState': Helper.capitalize(casPhysicalState, false),
              'casDiagnosis': Helper.capitalize(casDiagnosis, false),
              'casActualRoom':
                  'A$casFloorLevel - ${Helper.fillZero(casActualRoom)}',
              'casEntryArea': casEntryArea,
              'docId': docId,
              'casMethodOfEntry': casMethodOfEntry ? 'New' : 'Referral',
            };

            if (casAdmissionReason.isNotEmpty &&
                casSymptomatology.isNotEmpty &&
                casPhysicalState.isNotEmpty &&
                casDiagnosis.isNotEmpty &&
                casEntryArea.isNotEmpty &&
                casFloorLevel.isNotEmpty &&
                casActualRoom.isNotEmpty) {
              if (casStatus) {
                context
                    .read<NewCasePatientCubit>()
                    .createNewCaseByNewPatient(patData, casData, accessToken);
              } else {
                context
                    .read<NewCasePatientCubit>()
                    .createNewCaseByOldPatient(patData, casData, accessToken);
              }
            } else {
              FloatingWarningSnackBar.show(context, 'Aun faltan campos de texto por rellenar');
            }

            //Navigator.of(context).pushNamed(
            //    '/main/patients/',
            //    arguments: { "userData" : User(userName: "Pepe Loco", userEmail: "Pepeloco@gmail.com", userRoleUid: 16, userImgUrl: "", userProfileId: 23)}
            //); // TODO DELETE harcode Argument and refactor use (Deberia usar un POP UNTIL)
          },
        ));
  }
}
