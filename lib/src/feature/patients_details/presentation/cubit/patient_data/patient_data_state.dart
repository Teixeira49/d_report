import '../../../../../shared/data/model/view_details_status.dart';
import '../../../domain/entities/case_report.dart';
import '../../../domain/entities/patient.dart';

abstract class PatientDataState {}

class PatientDataInitial extends PatientDataState {}

class PatientDataLoading extends PatientDataState {}

class PatientDataLoaded extends PatientDataState {
  final Patient patient;
  final CaseReport caseReport;
  final ViewDetailsStatus permissionStatus;
  final int countDoctors;

  PatientDataLoaded(
      {required this.patient,
      required this.caseReport,
      required this.permissionStatus,
      required this.countDoctors});
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
