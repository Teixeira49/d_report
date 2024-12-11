abstract class CheckPatientState {

}

class CheckPatientInitial extends CheckPatientState {}

class CheckPatientLoading extends CheckPatientState {
}

class CheckPatientLoaded extends CheckPatientState {
  final String sms;
  CheckPatientLoaded({required this.sms});
}

class CheckPatientTimeout extends CheckPatientState {
  final String sms;
  CheckPatientTimeout({required this.sms});
}

class CheckPatientFail extends CheckPatientState {
  final String errorSMS;
  CheckPatientFail({required this.errorSMS});
}