import 'package:d_report/src/shared/domain/entities/case_report.dart';

abstract class SendEndCaseState {}

class SendEndCaseInitial extends SendEndCaseState {}

class SendEndCaseLoading extends SendEndCaseState {}

class SendEndCaseLoaded extends SendEndCaseState {
  final CaseReport caseReport;
  SendEndCaseLoaded({required this.caseReport});
}

class SendEndCaseTimeout extends SendEndCaseState {
  final String sms;
  SendEndCaseTimeout({required this.sms});
}

class SendEndCaseFail extends SendEndCaseState {
  final String errorSMS;
  SendEndCaseFail({required this.errorSMS});
}