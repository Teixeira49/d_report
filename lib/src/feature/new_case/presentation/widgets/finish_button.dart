import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/user.dart';
import '../cubit/new_patient/new_patient_case_cubit.dart';

class FinishRegisterCaseButton extends StatelessWidget {
  const FinishRegisterCaseButton(
      {super.key,
      required this.casSymptomatology,
      required this.casPhysicalState,
      required this.casDiagnosis,
      required this.casActualRoom,
      required this.casFloorLevel,
      required this.casEntryArea,
      required this.patData,
      required this.docId,
      required this.accessToken,
      required this.size,});

  final int docId;
  final String casSymptomatology;
  final String casPhysicalState;
  final String casDiagnosis;
  final String casActualRoom;
  final String casFloorLevel;
  final String casEntryArea;
  final Map<String, dynamic> patData;
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
          child:  Text("Guardar Paciente",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleLarge?.color,
                  fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
                  fontSize: 20
              )),
          onPressed: () {
            print(docId.runtimeType);
            Map<String, dynamic> casData = {
              'casSymptomatology': casSymptomatology,
              'casPhysicalState': casPhysicalState,
              'casDiagnosis': casDiagnosis,
              'casActualRoom': 'A$casFloorLevel - 0$casActualRoom',
              'casEntryArea': casEntryArea,
              'docId': docId,
              'casStudyImg': '',
              'casMethodOfEntry': 'New'
            };

            print(casData);
            context
                .read<NewCasePatientCubit>()
                .createNewCaseByNewPatient(patData, casData, accessToken);
            //Navigator.of(context).pushNamed(
            //    '/main/patients/',
            //    arguments: { "userData" : User(userName: "Pepe Loco", userEmail: "Pepeloco@gmail.com", userRoleUid: 16, userImgUrl: "", userProfileId: 23)}
            //); // TODO DELETE harcode Argument and refactor use (Deberia usar un POP UNTIL)
          },
        ));
  }
}
