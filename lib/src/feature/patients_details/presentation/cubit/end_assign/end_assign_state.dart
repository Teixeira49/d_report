
import 'package:d_report/src/feature/patients_details/domain/entities/care_assignment.dart';

abstract class EndAssignState {}

class EndAssignInitial extends EndAssignState {}

class EndAssignLoading extends EndAssignState {}

class EndAssignLoaded extends EndAssignState {
  final CareAssign endAssign;
  EndAssignLoaded({required this.endAssign});
}

class EndAssignTimeout extends EndAssignState {
  final String sms;
  EndAssignTimeout({required this.sms});
}

class EndAssignFail extends EndAssignState {
  final String errorSMS;
  EndAssignFail({required this.errorSMS});
}