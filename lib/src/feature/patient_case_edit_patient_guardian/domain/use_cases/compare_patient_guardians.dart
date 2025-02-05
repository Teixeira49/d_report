import '../../../../core/utils/constants/fields_constants.dart';
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
      if (originalPatGuJson[i] == null) {
        originalPatGuJson[i] = emptyString;
      }
      if (originalPatGuJson[i].toString().toLowerCase() != updatePatGuJson[i].toString().toLowerCase()) {
        if (updatePatGuJson[i] == emptyString) {
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
