import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/patient.dart';
import '../../../domain/entities/patient_edit_request.dart';
import '../../../domain/use_cases/compare_patients.dart';
import '../../../domain/use_cases/post_patient_data.dart';
import 'patient_editor_state.dart';

class PatientEditorCubit extends Cubit<PatientEditorState> {
  final PostPatientDataUseCase _postPatientDateUseCase;
  final ComparePatientsUseCase _comparePatientsUseCase;

  PatientEditorCubit(this._postPatientDateUseCase, this._comparePatientsUseCase)
      : super(PatientEditorInitial());

  Future<void> postChanges(PatientEditRequest patientEditRequest, Patient patient, int part, String accessToken) async {
    try {
      emit(PatientEditorLoading());
      final check = _comparePatientsUseCase.call(patient, patientEditRequest, part);
      if (check != null) {
        emit(PatientEditorWithoutUpdate(errorSMS: check));
      } else {
        final data = await _postPatientDateUseCase.call(patientEditRequest, part, accessToken);
        data.fold((l) => emit(PatientEditorFail(errorSMS: l.message)),
                (r) => emit(PatientEditorPosted(patientEditRequest: r)));
      }
    } catch (e) {
      emit(PatientEditorFail(errorSMS: e.toString()));
    }
  }
}
