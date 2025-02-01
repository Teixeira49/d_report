import '../../../domain/entities/patient.dart';

abstract class FindPatientState {}

class FindPatientInitial extends FindPatientState {}

class FindPatientLoading extends FindPatientState {
}

class FindPatientLoaded extends FindPatientState {
  final List<SearchPatient> patients;
  final String filter;
  final bool isComplete;

  FindPatientLoaded({required this.patients, this.filter = '', this.isComplete = false});

  FindPatientLoaded copyWith({List<SearchPatient>? patients, String? filter, bool? isComplete}) {
    return FindPatientLoaded(
      patients: patients != null ? [...patients, ...this.patients] : this.patients,
      filter: filter ?? this.filter,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}

class FindPatientLoadedButEmpty extends FindPatientState {
  final String sms;
  FindPatientLoadedButEmpty({required this.sms});
}

class FindPatientTimeout extends FindPatientState {
  final String errorSMS;
  FindPatientTimeout({required this.errorSMS});
}

class FindPatientFail extends FindPatientState {
  final String errorSMS;
  FindPatientFail({required this.errorSMS});
}