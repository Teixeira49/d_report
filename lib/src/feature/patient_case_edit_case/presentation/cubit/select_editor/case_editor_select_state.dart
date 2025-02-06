import '../../../../../core/utils/constants/fields_constants.dart';
import '../../../domain/entities/case_report.dart';

abstract class CaseEditorSelectState {
  CaseEditorSelectState copyWith({String newTitle, CaseReport newCaseReport, bool isUpdated});

  String getSelectionTitle();

  CaseReport? getSelectionCase();

  bool getEditedStatus();
}

class CaseEditorSelectRows extends CaseEditorSelectState {
  final String title;
  final CaseReport? caseReport;
  final bool isEdited;

  CaseEditorSelectRows({this.title = emptyString, this.caseReport, this.isEdited = false});

  @override
  CaseEditorSelectRows copyWith({String? newTitle, CaseReport? newCaseReport, bool? isUpdated}) {
    return CaseEditorSelectRows(
        title: newTitle ?? title, caseReport: newCaseReport ?? caseReport, isEdited: isUpdated ?? isEdited);
  }

  @override
  String getSelectionTitle() {
    return title;
  }

  @override
  CaseReport? getSelectionCase() {
    return caseReport;
  }

  @override
  bool getEditedStatus() {
    return isEdited;
  }
}
