import '../../data/models/patient_guardian_edit_request_model.dart';
import '../../data/models/patient_guardian_model.dart';
import '../entities/patient_guardian.dart';
import '../entities/patient_guardian_edit_request.dart';

class ComparePatientGuardiansUseCase {
  ComparePatientGuardiansUseCase();

  String? call(
      PatientGuardian originalPatGu, PatientGuardianEditRequest updatePatGu) {
    dynamic originalPatGuJson =
        PatientGuardianModel.fromEntity(originalPatGu).toJson();
    dynamic updatePatGuJson =
        PatientGuardianEditRequestModel.fromEntity(updatePatGu).toJson();

    String? error = 'Porfavor, realice modificaciones a los datos.';

    List<String> patGuRows = [
      'patGuardianDni',
      'patGuardianAddress',
      'patGuardianPhone',
      'patGuardianEmail'
    ];

    for (var i in patGuRows) {
      print('$i ${originalPatGuJson[i]} ${updatePatGuJson[i]}');
      if (originalPatGuJson[i] == null) {
        originalPatGuJson[i] = '';
      }
      if (originalPatGuJson[i].toString().toLowerCase() != updatePatGuJson[i].toString().toLowerCase()) {
        if (updatePatGuJson[i] == '') {
          error = 'Porfavor, no deje campos por rellenar.';
        } else {
          error = null;
        }
        break;
      }
    }
    return error;
  }
}
