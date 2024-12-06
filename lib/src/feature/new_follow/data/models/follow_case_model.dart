


import '../../domain/entities/follow_case.dart';

class FollowModel extends FollowCase {

  FollowModel({
    required  super .cafId,
    required  super .cafReportType,
    required  super .cafReportInfo,
    required  super .docId,
    required  super .cafReportTitle,
  });

  factory FollowModel.fromJson(json) {
    return FollowModel(
      cafReportType: json['cafReportType'],
      cafId: json['cafId'],
      cafReportInfo: json['cafReportDate'],
      docId: json['docId'],
      cafReportTitle: json['cafReportTitle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cafId': cafId,
      'cafReportType': cafReportType,
      'cafReportInfo': cafReportInfo,
      'docId': docId,
      'cafReportTitle': cafReportTitle,
    };
  }

  factory FollowModel.fromEntity(FollowCase followCase) {
    return FollowModel(
      cafId: followCase.cafId,
      cafReportType: followCase.cafReportType,
      cafReportInfo: followCase.cafReportInfo,
      docId: followCase.docId,
      cafReportTitle: followCase.cafReportTitle,
    );
  }
}