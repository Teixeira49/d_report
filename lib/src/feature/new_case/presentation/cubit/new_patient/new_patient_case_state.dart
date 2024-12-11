import 'package:d_report/src/shared/domain/entities/case_report.dart';

abstract class NewCasePatientState {

}

class NewCasePatientInitial extends NewCasePatientState {}

class NewCasePatientLoading extends NewCasePatientState {
}

class NewCasePatientLoaded extends NewCasePatientState {
  final CaseReport caseReport;
  NewCasePatientLoaded({required this.caseReport});
}

class NewCasePatientTimeout extends NewCasePatientState {
  final String sms;
  NewCasePatientTimeout({required this.sms});
}

class NewCasePatientFail extends NewCasePatientState {
  final String errorSMS;
  NewCasePatientFail({required this.errorSMS});
}