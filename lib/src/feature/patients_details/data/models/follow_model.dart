import '../../domain/entities/follows_in_case.dart';
import 'package:d_report/src/core/helpers/helpers.dart';


class FollowModel extends FollowCase {

  FollowModel({
    required  super .cafId,
    required  super .cafReportType,
    required  super .cafReportDate,
    required  super .docId,
    required  super .cafReportTitle,
  });

  factory FollowModel.fromJson(json) {
    return FollowModel(
        cafReportType: json['cafReportType'],
        cafId: json['cafId'],
        cafReportDate: Helper.getDateSMSByString(json['cafReportDate']),
        docId: json['docId'],
        cafReportTitle: json['cafReportTitle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cafId': cafId,
      'cafReportType': cafReportType,
      'cafReportDate': cafReportDate,
      'docId': docId,
      'cafReportTitle': cafReportTitle,
    };
  }

  factory FollowModel.fromEntity(FollowCase followCase) {
    return FollowModel(
      cafId: followCase.cafId,
      cafReportType: followCase.cafReportType,
      cafReportDate: followCase.cafReportDate,
      docId: followCase.docId,
      cafReportTitle: followCase.cafReportTitle,
    );
  }
}