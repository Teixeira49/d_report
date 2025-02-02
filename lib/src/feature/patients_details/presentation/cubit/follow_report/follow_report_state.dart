import 'package:d_report/src/feature/patients_details/domain/entities/follows_in_case.dart';

abstract class FollowReportState {}

class FollowCaseInitial extends FollowReportState {}

class FollowCaseLoading extends FollowReportState {}

class FollowCaseLoaded extends FollowReportState {
  final List<FollowCase> followCase;
  final String filter;
  final bool isComplete;
  final int countTotal;

  FollowCaseLoaded(
      {required this.followCase,
      this.filter = '',
      this.isComplete = false,
      required this.countTotal});

  FollowCaseLoaded copyWith(
      {List<FollowCase>? follows, int? count, String? filter, bool? isComplete}) {
    return FollowCaseLoaded(
      followCase: follows != null ? [...follows , ...followCase] : followCase,
      filter: filter ?? this.filter,
      countTotal: count ?? countTotal,
      isComplete: isComplete ?? this.isComplete,
    );
  }
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
