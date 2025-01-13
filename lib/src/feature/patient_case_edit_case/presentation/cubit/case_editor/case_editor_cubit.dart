import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/post_case_data.dart';
import 'case_editor_state.dart';

class CaseEditorCubit extends Cubit<CaseEditorState> {
  final PostCaseDateUseCase _postCaseDateUseCase;

  CaseEditorCubit(this._postCaseDateUseCase) : super(CaseEditorInitial());

  Future<void> postChanges(String accessToken) async {
    try {
      emit(CaseEditorLoading());

      final data = await _postCaseDateUseCase.call(accessToken);

      data.fold((l) => emit(CaseEditorFail(errorSMS: l.message)),
          (r) => emit(CaseEditorPosted(caseReportEditRequest: r)));
    } catch (e) {
      emit(CaseEditorFail(errorSMS: e.toString()));
    }
  }
}
