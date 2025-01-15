import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/post_patient_data.dart';
import 'patient_editor_state.dart';

class PatientEditorCubit extends Cubit<PatientEditorState> {
  final PostPatientDataUseCase _postPatientDateUseCase;

  PatientEditorCubit(this._postPatientDateUseCase) : super(PatientEditorInitial());

  Future<void> postChanges(String accessToken) async {
    try {
      emit(PatientEditorLoading());

      final data = await _postPatientDateUseCase.call(accessToken);

      data.fold((l) => emit(PatientEditorFail(errorSMS: l.message)),
          (r) => emit(PatientEditorPosted(patientEditRequest: r)));
    } catch (e) {
      emit(PatientEditorFail(errorSMS: e.toString()));
    }
  }
}
