import 'package:d_report/src/core/helpers/helpers.dart';

import '../../domain/entities/follows_detailed_case.dart';

class FollowDetailedModel extends FollowDetailedCase {

  FollowDetailedModel({
    required  super .cafId,
    required  super .cafReportType,
    required  super .cafReportInfo,
    required  super .cafReportDate,
    required  super .docFullName,
    required  super .docSpecialty,
    required  super .cafReportTitle,
    required  super .cafReportUpdateTime,
  });

  factory FollowDetailedModel.fromJson(json) {
    return FollowDetailedModel(
        cafReportType: json['cafReportType'],
        cafReportInfo: json['cafReportInfo'],
        cafId: json['cafId'],
        cafReportDate: Helper.getDateSMSByString(json['cafReportDate']),
        docFullName: Helper.getFullNameInRow(json['docId']['docFirstName'], json['docId']['docLastName']) ,
        docSpecialty: json['docId']['docSpecialty'],
        cafReportTitle: json['cafReportTitle'],
        cafReportUpdateTime: Helper.getDateSMSByString(json['cafReportUpdateTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cafId': cafId,
      'cafReportType': cafReportType,
      'cafReportInfo': cafReportInfo,
      'cafReportDate': cafReportDate,
      'docFullName': docFullName,
      'docSpecialty': docSpecialty,
      'cafReportTitle': cafReportTitle,
      'cafReportUpdateTime': cafReportUpdateTime,
    };
  }

  factory FollowDetailedModel.fromEntity(FollowDetailedCase followDetailedCase) {
    return FollowDetailedModel(
      cafId: followDetailedCase.cafId,
      cafReportType: followDetailedCase.cafReportType,
      cafReportInfo: followDetailedCase.cafReportInfo,
      cafReportDate: followDetailedCase.cafReportDate,
      docFullName: followDetailedCase.docFullName,
      docSpecialty: followDetailedCase.docSpecialty,
      cafReportTitle: followDetailedCase.cafReportTitle,
      cafReportUpdateTime: followDetailedCase.cafReportUpdateTime,
    );
  }
}