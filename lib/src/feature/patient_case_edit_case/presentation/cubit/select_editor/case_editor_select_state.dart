import '../../../../../core/utils/constants/fields_constants.dart';
import '../../../domain/entities/case_report.dart';

abstract class CaseEditorSelectState {
  CaseEditorSelectState copyWith({String newTitle, CaseReport newCaseReport});

  String getSelectionTitle();

  CaseReport? getSelectionCase();
}

class CaseEditorSelectRows extends CaseEditorSelectState {
  final String title;
  final CaseReport? caseReport;

  CaseEditorSelectRows({this.title = emptyString, this.caseReport});

  @override
  CaseEditorSelectRows copyWith({String? newTitle, CaseReport? newCaseReport}) {
    return CaseEditorSelectRows(
        title: newTitle ?? title, caseReport: newCaseReport ?? caseReport);
  }

  @override
  String getSelectionTitle() {
    return title;
  }

  @override
  CaseReport? getSelectionCase() {
    return caseReport;
  }
}
