import '../../../domain/entities/patient_guardian.dart';

abstract class PatientGuardianEditorSelectState {
  PatientGuardianEditorSelectState copyWith(
      {String newTitle, PatientGuardian newPatientGuardian});

  String getSelectionTitle();

  PatientGuardian? getSelectionGuPat();
}

class PatientGuardianEditorSelectRows extends PatientGuardianEditorSelectState {
  final String title;
  final PatientGuardian? patientGuardian;

  PatientGuardianEditorSelectRows({this.title = '', this.patientGuardian});

  @override
  PatientGuardianEditorSelectRows copyWith(
      {String? newTitle, PatientGuardian? newPatientGuardian}) {
    return PatientGuardianEditorSelectRows(
        title: newTitle ?? title,
        patientGuardian: newPatientGuardian ?? patientGuardian);
  }

  @override
  String getSelectionTitle() {
    return title;
  }

  @override
  PatientGuardian? getSelectionGuPat() {
    return patientGuardian;
  }
}
