import 'package:d_report/src/feature/patient_case_edit_patient_guardian/domain/entities/patient_guardian_edit_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/patient_guardian.dart';
import '../../../domain/use_cases/compare_patient_guardians.dart';
import '../../../domain/use_cases/post_patient_guardian_data.dart';
import 'patient_guardian_editor_state.dart';

class PatientGuardianEditorCubit extends Cubit<PatientGuardianEditorState> {
  final PostPatientGuardianDateUseCase _postPatientGuardianDateUseCase;
  final ComparePatientGuardiansUseCase _comparePatientGuardiansUseCase;

  PatientGuardianEditorCubit(this._postPatientGuardianDateUseCase,
      this._comparePatientGuardiansUseCase)
      : super(PatientGuardianEditorInitial());

  Future<void> postChanges(
      PatientGuardianEditRequest patientGuardianEditRequest,
      PatientGuardian patientGuardian,
      String accessToken) async {
    try {
      emit(PatientGuardianEditorLoading());
      final check = _comparePatientGuardiansUseCase.call(
          patientGuardian, patientGuardianEditRequest);
      if (check != null) {
        emit(PatientGuardianEditorWithoutUpdate(errorSMS: check));
      } else {
        final data = await _postPatientGuardianDateUseCase.call(
            patientGuardianEditRequest, accessToken);
        data.fold(
            (l) => emit(PatientGuardianEditorFail(errorSMS: l.message)),
            (r) => emit(
                PatientGuardianEditorPosted(patientGuardianEditRequest: r)));
      }
    } catch (e) {
      emit(PatientGuardianEditorFail(errorSMS: e.toString()));
    }
  }
}
