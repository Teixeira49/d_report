
import 'package:d_report/src/feature/patients_details/domain/entities/follows_in_case.dart';

abstract class FollowReportState {}

class FollowCaseInitial extends FollowReportState {}

class FollowCaseLoaded extends FollowReportState {
  final List<FollowCase> followCase;
  FollowCaseLoaded({required this.followCase});
}

class FollowCaseLoadedButEmpty extends FollowReportState {
  final String sms;
  FollowCaseLoadedButEmpty({required this.sms});
}

class FollowCaseTimeout extends FollowReportState {
  final String sms;
  FollowCaseTimeout({required this.sms});
}

class FollowCaseFail extends FollowReportState {
  final String errorSMS;
  FollowCaseFail({required this.errorSMS});
}