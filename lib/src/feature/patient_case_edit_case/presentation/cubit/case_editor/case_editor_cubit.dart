import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/case_report.dart';
import '../../../domain/entities/case_report_edit_request.dart';
import '../../../domain/use_cases/compare_cases.dart';
import '../../../domain/use_cases/post_case_data.dart';
import 'case_editor_state.dart';

class CaseEditorCubit extends Cubit<CaseEditorState> {
  final PostCaseDateUseCase _postCaseDateUseCase;
  final CompareCasesUseCase _compareCasesUseCase;

  CaseEditorCubit(this._postCaseDateUseCase, this._compareCasesUseCase) : super(CaseEditorInitial());

  Future<void> postChanges(CaseReportEditRequest caseReportEditRequest, CaseReport caseReport, int part, String accessToken) async {
    try {
      emit(CaseEditorLoading());
      final check = _compareCasesUseCase.call(caseReport, caseReportEditRequest, part);
      if (check != null) {
        emit(CaseEditorWithoutUpdate(errorSMS: check));
      } else {
        final data = await _postCaseDateUseCase.call(caseReportEditRequest, part, accessToken);
        data.fold((l) => emit(CaseEditorFail(errorSMS: l.message)),
                (r) => emit(CaseEditorPosted(caseReportEditRequest: r)));
      }
    } catch (e) {
      emit(CaseEditorFail(errorSMS: e.toString()));
    }
  }
}
