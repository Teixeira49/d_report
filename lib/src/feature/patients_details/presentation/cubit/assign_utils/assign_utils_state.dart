import 'package:d_report/src/feature/patients_details/domain/entities/care_assignment.dart';

abstract class AssignUtilsState {}

class AssignUtilsInitial extends AssignUtilsState {}

class AssignUtilsLoading extends AssignUtilsState {}

class AssignUtilsLoaded extends AssignUtilsState {
  final String sms;
  final CareAssign endAssign;
  AssignUtilsLoaded({required this.sms, required this.endAssign});
}

class AssignUtilsTimeout extends AssignUtilsState {
  final String sms;
  AssignUtilsTimeout({required this.sms});
}

class AssignUtilsFail extends AssignUtilsState {
  final String errorSMS;
  AssignUtilsFail({required this.errorSMS});
}