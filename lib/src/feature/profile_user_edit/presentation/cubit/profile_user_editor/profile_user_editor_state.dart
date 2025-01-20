import '../../../domain/entities/doctor.dart';

abstract class ProfileUserEditState {}

class ProfileUserEditInitial extends ProfileUserEditState {}

class ProfileUserEditLoading extends ProfileUserEditState {}

class ProfileUserEditLoaded extends ProfileUserEditState {
  final Doctor doctor;
  ProfileUserEditLoaded({required this.doctor});
}

class ProfileUserEditLoadedButEmpty extends ProfileUserEditState {
  final String sms;
  ProfileUserEditLoadedButEmpty({required this.sms});
}

class ProfileUserEditTimeout extends ProfileUserEditState {
  final String sms;
  ProfileUserEditTimeout({required this.sms});
}

class ProfileUserEditFail extends ProfileUserEditState {
  final String errorSMS;
  ProfileUserEditFail({required this.errorSMS});
}