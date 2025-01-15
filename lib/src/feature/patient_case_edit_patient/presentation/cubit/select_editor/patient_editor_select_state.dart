import '../../../domain/entities/patient.dart';

abstract class PatientEditorSelectState {
  PatientEditorSelectState copyWith({String newTitle, Patient newPatient});

  String getSelectionTitle();

  Patient? getSelectionPat();
}

class PatientEditorSelectRows extends PatientEditorSelectState {
  final String title;
  final Patient? patient;

  PatientEditorSelectRows({this.title = '', this.patient});

  @override
  PatientEditorSelectRows copyWith({String? newTitle, Patient? newPatient}) {
    return PatientEditorSelectRows(
        title: newTitle ?? title, patient: newPatient ?? patient);
  }

  @override
  String getSelectionTitle() {
    return title;
  }

  @override
  Patient? getSelectionPat() {
    return patient;
  }
}
