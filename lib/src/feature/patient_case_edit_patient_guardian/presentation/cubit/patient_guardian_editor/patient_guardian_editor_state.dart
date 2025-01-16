import '../../../domain/entities/patient_guardian_edit_request.dart';

abstract class PatientGuardianEditorState {

}

class PatientGuardianEditorInitial extends PatientGuardianEditorState {}

class PatientGuardianEditorLoading extends PatientGuardianEditorState {}

class PatientGuardianEditorPosted extends PatientGuardianEditorState {
  PatientGuardianEditRequest patientGuardianEditRequest;
  PatientGuardianEditorPosted({required this.patientGuardianEditRequest});
}

class PatientGuardianEditorTimeout extends PatientGuardianEditorState {
  final String sms;
  PatientGuardianEditorTimeout({required this.sms});
}

class PatientGuardianEditorFail extends PatientGuardianEditorState {
  final String errorSMS;
  PatientGuardianEditorFail({required this.errorSMS});
}

class PatientGuardianEditorWithoutUpdate extends PatientGuardianEditorState {
  final String errorSMS;
  PatientGuardianEditorWithoutUpdate({required this.errorSMS});
}