import '../../data/models/patient_guardian_model.dart';
import '../entities/patient_guardian.dart';

class CreateInstancePatientGuardianUseCase {

  CreateInstancePatientGuardianUseCase();

  PatientGuardian call(dynamic patientJson) {
    return patientJson;//TODO HARDCODE PatientGuardianModel.fromJson(patientJson); // TODO HARDCODE
  }
}