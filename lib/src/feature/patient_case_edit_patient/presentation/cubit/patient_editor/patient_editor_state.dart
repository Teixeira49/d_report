
import '../../../domain/entities/patient_edit_request.dart';

abstract class PatientEditorState {

}

class PatientEditorInitial extends PatientEditorState {}

class PatientEditorLoading extends PatientEditorState {}

class PatientEditorPosted extends PatientEditorState {
  PatientEditRequest patientEditRequest;
  PatientEditorPosted({required this.patientEditRequest});
}

class PatientEditorTimeout extends PatientEditorState {
  final String sms;
  PatientEditorTimeout({required this.sms});
}

class PatientEditorFail extends PatientEditorState {
  final String errorSMS;
  PatientEditorFail({required this.errorSMS});
}

class PatientEditorWithoutUpdate extends PatientEditorState {
  final String errorSMS;

  PatientEditorWithoutUpdate({required this.errorSMS});
}