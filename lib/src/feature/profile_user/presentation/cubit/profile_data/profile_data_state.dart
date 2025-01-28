import '../../../../../shared/domain/entities/doctor.dart';

abstract class ProfileDataState {}

class ProfileDataInitial extends ProfileDataState {}

class ProfileDataLoading extends ProfileDataState {}

class ProfileDataLoaded extends ProfileDataState {
  final DoctorProfile doctor;
  ProfileDataLoaded({required this.doctor});
}

class ProfileDataLoadedButEmpty extends ProfileDataState {
  final String sms;
  ProfileDataLoadedButEmpty({required this.sms});
}

class ProfileDataTimeout extends ProfileDataState {
  final String sms;
  ProfileDataTimeout({required this.sms});
}

class ProfileDataFail extends ProfileDataState {
  final String errorSMS;
  ProfileDataFail({required this.errorSMS});
}