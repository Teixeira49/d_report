
import '../../../domain/entities/case_report_edit_request.dart';

abstract class CaseEditorState {

}

class CaseEditorInitial extends CaseEditorState {}

class CaseEditorLoading extends CaseEditorState {}

class CaseEditorPosted extends CaseEditorState {
  CaseReportEditRequest caseReportEditRequest;
  CaseEditorPosted({required this.caseReportEditRequest});
}

class CaseEditorTimeout extends CaseEditorState {
  final String sms;
  CaseEditorTimeout({required this.sms});
}

class CaseEditorFail extends CaseEditorState {
  final String errorSMS;
  CaseEditorFail({required this.errorSMS});
}

class CaseEditorWithoutUpdate extends CaseEditorState {
  final String errorSMS;
  CaseEditorWithoutUpdate({required this.errorSMS});
}