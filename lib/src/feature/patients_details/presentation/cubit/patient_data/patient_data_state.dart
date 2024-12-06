
import '../../../domain/entities/case_report.dart';
import '../../../domain/entities/patient.dart';

abstract class PatientDataState {

}

class PatientDataInitial extends PatientDataState {}

class PatientDataLoaded extends PatientDataState {
  final Patient patient;
  final CaseReport caseReport;
  PatientDataLoaded({required this.patient, required this.caseReport});
}

class PatientDataLoadedButEmpty extends PatientDataState {
  final String sms;
  PatientDataLoadedButEmpty({required this.sms});
}

class PatientDataTimeout extends PatientDataState {
  final String sms;
  PatientDataTimeout({required this.sms});
}

class PatientDataFail extends PatientDataState {
  final String errorSMS;
  PatientDataFail({required this.errorSMS});
}