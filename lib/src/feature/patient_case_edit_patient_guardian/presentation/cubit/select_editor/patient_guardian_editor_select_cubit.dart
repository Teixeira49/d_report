import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../domain/entities/patient_guardian.dart';
import '../../../domain/use_cases/create_instance_patient_guardian.dart';
import 'patient_guardian_editor_select_state.dart';

class PatientGuardianEditorSelectCubit
    extends Cubit<PatientGuardianEditorSelectState> {

  final CreateInstancePatientGuardianUseCase _createInstanceCaseReportUseCase;

  PatientGuardianEditorSelectCubit(this._createInstanceCaseReportUseCase)
      : super(PatientGuardianEditorSelectRows());

  void onModifySelection(String title, dynamic patientJson) {
    PatientGuardian patientGuardian = _createInstanceCaseReportUseCase.call(patientJson);
    emit(state.copyWith(newTitle: title, newPatientGuardian: patientGuardian));
  }

  void setOriginalPatient(dynamic patientJson) {
    PatientGuardian patientGuardian = _createInstanceCaseReportUseCase.call(patientJson);
    emit(state.copyWith(newPatientGuardian: patientGuardian));
  }

  String getSelectionTitle() {
    if (state is PatientGuardianEditorSelectRows) {
      return state.getSelectionTitle();
    }
    return '';
  }

  PatientGuardian? getSelectionPatient() {
    return state.getSelectionGuPat();
  }

}
