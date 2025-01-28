import '../../../../../shared/domain/entities/doctor.dart';

abstract class ProfileUserEditState {}

class ProfileUserEditInitial extends ProfileUserEditState {}

class ProfileUserEditLoading extends ProfileUserEditState {}

class ProfileUserEditPosted extends ProfileUserEditState {
  final DoctorProfile doctor;
  ProfileUserEditPosted({required this.doctor});
}

class ProfileUserEditWithoutUpdate extends ProfileUserEditState {
  final String sms;
  ProfileUserEditWithoutUpdate({required this.sms});
}

class ProfileUserEditTimeout extends ProfileUserEditState {
  final String sms;
  ProfileUserEditTimeout({required this.sms});
}

class ProfileUserEditFail extends ProfileUserEditState {
  final String errorSMS;
  ProfileUserEditFail({required this.errorSMS});
}