import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/patient.dart';
import '../../../domain/use_cases/create_instance_patient.dart';
import 'patient_editor_select_state.dart';

class PatientEditorSelectCubit extends Cubit<PatientEditorSelectState> {

  final CreateInstancePatientUseCase _createInstanceCaseReportUseCase;

  PatientEditorSelectCubit(this._createInstanceCaseReportUseCase) : super(PatientEditorSelectRows());

  void onModifySelection(String title, dynamic caseJson) {
    Patient patient = _createInstanceCaseReportUseCase.call(caseJson);
    emit(state.copyWith(newTitle: title, newCaseReport: patient));
  }

  void setOriginalPatient(dynamic caseJson) {
    Patient patient = _createInstanceCaseReportUseCase.call(caseJson);
    emit(state.copyWith(newCaseReport: patient));
  }

  String getSelectionTitle() {
    if (state is PatientEditorSelectRows) {
      return state.getSelectionTitle();
    }
    return '';
  }

  Patient? getSelectionPatient() {
    return state.getSelectionPat();
  }

}
