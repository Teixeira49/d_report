import '../../data/models/patient_model.dart';
import '../entities/patient.dart';

class CreateInstancePatientUseCase {

  CreateInstancePatientUseCase();

  Patient call(dynamic caseJson) {
    return PatientModel.fromJson(caseJson);
  }
}