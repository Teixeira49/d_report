import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/patient.dart';
import '../../../domain/use_cases/create_instance_patient.dart';
import 'patient_editor_select_state.dart';

class PatientEditorSelectCubit extends Cubit<PatientEditorSelectState> {

  final CreateInstancePatientUseCase _createInstanceCaseReportUseCase;

  PatientEditorSelectCubit(this._createInstanceCaseReportUseCase) : super(PatientEditorSelectRows());

  void onModifySelection(String title, dynamic patientJson) {
    Patient patient = _createInstanceCaseReportUseCase.call(patientJson);
    emit(state.copyWith(newTitle: title, newPatient: patient));
  }

  void setOriginalPatient(dynamic patientJson) {
    patientJson['patName'] = patientJson['patFirstName'];// TODO Impl a unique politic please for fix this.
    patientJson['patSecName'] = patientJson['patSecondName'];
    patientJson['patLastName'] = patientJson['patLastname'];
    patientJson['patSecSurName'] = patientJson['patSecondSurname'];
    Patient patient = _createInstanceCaseReportUseCase.call(patientJson);
    emit(state.copyWith(newPatient: patient));
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
