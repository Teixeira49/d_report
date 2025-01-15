import '../../data/models/patient_model.dart';
import '../entities/patient.dart';

class CreateInstancePatientUseCase {

  CreateInstancePatientUseCase();

  Patient call(dynamic patientJson) {
    return PatientModel.fromJson(patientJson);
  }
}