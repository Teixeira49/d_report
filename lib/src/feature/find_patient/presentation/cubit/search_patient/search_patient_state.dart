import '../../../domain/entities/patient.dart';

abstract class FindPatientState {

}

class FindPatientInitial extends FindPatientState {}

class FindPatientLoading extends FindPatientState {
}

class FindPatientLoaded extends FindPatientState {
  final List<Patient> patients;
  FindPatientLoaded({required this.patients});
}

class FindPatientLoadedButEmpty extends FindPatientState {
  final String sms;
  FindPatientLoadedButEmpty({required this.sms});
}

class FindPatientTimeout extends FindPatientState {
  final String sms;
  FindPatientTimeout({required this.sms});
}

class FindPatientFail extends FindPatientState {
  final String errorSMS;
  FindPatientFail({required this.errorSMS});
}