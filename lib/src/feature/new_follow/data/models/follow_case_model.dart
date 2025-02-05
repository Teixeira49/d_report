


import '../../domain/entities/follow_case.dart';

class FollowModel extends FollowCase {

  FollowModel({
    required  super .casId,
    required  super .cafReportType,
    required  super .cafReportInfo,
    required  super .docId,
    required  super .cafReportTitle,
  });

  factory FollowModel.fromJson(json) {
    return FollowModel(
      cafReportType: json['cafReportType'],
      casId: json['casId'],
      cafReportInfo: json['cafReportDate'],
      docId: json['docId']['docId'],
      cafReportTitle: json['cafReportTitle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'casId': casId,
      'cafReportType': cafReportType,
      'cafReportInfo': cafReportInfo,
      'docId': docId,
      'cafReportTitle': cafReportTitle,
    };
  }

  factory FollowModel.fromBodyJson(json) {
    return FollowModel(
      casId: json['casId'],
      cafReportType: "Text",
      cafReportInfo: json['info'],
      docId: json['docId'],
      cafReportTitle: json['title'],
    );
  }

  factory FollowModel.fromEntity(FollowCase followCase) {
    return FollowModel(
      casId: followCase.casId,
      cafReportType: followCase.cafReportType,
      cafReportInfo: followCase.cafReportInfo,
      docId: followCase.docId,
      cafReportTitle: followCase.cafReportTitle,
    );
  }
}