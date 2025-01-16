import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/case_report.dart';
import '../../../domain/use_cases/create_instance_report.dart';
import 'case_editor_select_state.dart';

class CaseEditorSelectCubit extends Cubit<CaseEditorSelectState> {

  final CreateInstanceCaseReportUseCase _createInstanceCaseReportUseCase;

  CaseEditorSelectCubit(this._createInstanceCaseReportUseCase) : super(CaseEditorSelectRows());

  void onModifySelection(String title, dynamic caseJson) {
    CaseReport caseReport = _createInstanceCaseReportUseCase.call(caseJson);
    emit(state.copyWith(newTitle: title, newCaseReport: caseReport));
  }

  void setOriginalCase(dynamic caseJson) {
    CaseReport caseReport = _createInstanceCaseReportUseCase.call(caseJson);
    emit(state.copyWith(newCaseReport: caseReport));
  }

  String getSelectionTitle() {
    if (state is CaseEditorSelectRows) {
      return state.getSelectionTitle();
    }
    return '';
  }

  CaseReport? getSelectionCase() {
    return state.getSelectionCase();
  }

}
