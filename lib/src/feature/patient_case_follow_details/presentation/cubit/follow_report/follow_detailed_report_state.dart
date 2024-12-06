
import 'package:d_report/src/feature/patient_case_follow_details/domain/entities/follows_detailed_case.dart';

abstract class FollowDetailedReportState {}

class FollowDetailedCaseInitial extends FollowDetailedReportState {}

class FollowDetailedCaseLoaded extends FollowDetailedReportState {
  final FollowDetailedCase followDetailedCase;
  FollowDetailedCaseLoaded({required this.followDetailedCase});
}

class FollowDetailedCaseLoadedButEmpty extends FollowDetailedReportState {
  final String sms;
  FollowDetailedCaseLoadedButEmpty({required this.sms});
}

class FollowDetailedCaseTimeout extends FollowDetailedReportState {
  final String sms;
  FollowDetailedCaseTimeout({required this.sms});
}

class FollowDetailedCaseFail extends FollowDetailedReportState {
  final String errorSMS;
  FollowDetailedCaseFail({required this.errorSMS});
}