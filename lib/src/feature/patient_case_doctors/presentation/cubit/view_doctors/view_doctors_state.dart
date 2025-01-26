import 'package:d_report/src/feature/patient_case_doctors/domain/entities/assigned_doctor.dart';

abstract class ViewDoctorsState {}

class ViewDoctorsInitial extends ViewDoctorsState {}

class ViewDoctorsLoading extends ViewDoctorsState {}

class ViewDoctorsLoaded extends ViewDoctorsState {
  List<AssignedDoctor> listAssignedDoctors;
  int countTotalAssignedDoctors;
  final String filter;

  ViewDoctorsLoaded(
      {required this.listAssignedDoctors,
      required this.countTotalAssignedDoctors,
      this.filter = ''});

  ViewDoctorsLoaded copyWith(
      {List<AssignedDoctor>? doctors, int? count, String? filter}) {
    return ViewDoctorsLoaded(
      listAssignedDoctors: doctors ?? listAssignedDoctors,
      countTotalAssignedDoctors: count ?? countTotalAssignedDoctors,
      filter: filter ?? this.filter,
    );
  }
}

class ViewDoctorsTimeout extends ViewDoctorsState {
  final String sms;

  ViewDoctorsTimeout({required this.sms});
}

class ViewDoctorsFail extends ViewDoctorsState {
  final String errorSMS;

  ViewDoctorsFail({required this.errorSMS});
}

class ViewDoctorsWithoutUpdate extends ViewDoctorsState {
  final String errorSMS;

  ViewDoctorsWithoutUpdate({required this.errorSMS});
}
