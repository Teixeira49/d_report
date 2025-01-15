import '../../../../core/utils/constants/fields_constants.dart';
import '../../data/models/patient_model.dart';
import '../../data/models/patient_report_edit_request_model.dart';
import '../entities/patient.dart';
import '../entities/patient_edit_request.dart';

class ComparePatientsUseCase {
  ComparePatientsUseCase();

  String? call(Patient originalPat, PatientEditRequest updatePat, int part) {
    dynamic originalPatJson = PatientModel.fromEntity(originalPat).toJson();
    dynamic updatePatJson =
        PatientEditRequestModel.fromEntity(updatePat).toJson();

    String? error = 'Porfavor, realice modificaciones al Paciente.';

    List<String> patRows = checkEqualityUpdatePatient[part]!;

    for (var i in patRows) {
      if (originalPatJson[i].toString().toLowerCase() !=
          updatePatJson[i].toString().toLowerCase()) {
        if (updatePatJson[i] == '') {
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
