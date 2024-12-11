import 'package:d_report/src/core/helpers/helpers.dart';
import '../../domain/entities/add_case.dart';

class NewCaseReportModel extends NewCaseReport {
  NewCaseReportModel({
    required super.docId,
    required super.casSymptomatology,
    required super.casPhysicalState,
    required super.casDiagnosis,
    required super.casStudyImg,
    required super.casMethodOfEntry,
    required super.casActualRoom,
    required super.casEntryArea,
  });

  factory NewCaseReportModel.fromJson(json) {
    return NewCaseReportModel(
      docId: json['docId'],
      casSymptomatology: json['casSymptomatology'],
      casPhysicalState: json['casPhysicalState'],
      casDiagnosis: json['casDiagnosis'],
      casStudyImg: json['casStudyImg'],
      casMethodOfEntry: json['casMethodOfEntry'],
      casActualRoom: json['casActualRoom'],
      casEntryArea: json['casEntryArea'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'casSymptomatology': casSymptomatology,
      'casPhysicalState': casPhysicalState,
      'casDiagnosis': casDiagnosis,
      'casStudyImg': casStudyImg,
      'casMethodOfEntry': casMethodOfEntry,
      'casActualRoom': casActualRoom,
      'casEntryArea': casEntryArea,
    };
  }

  factory NewCaseReportModel.fromEntity(NewCaseReport caseReport) {
    return NewCaseReportModel(
      docId: caseReport.docId,
      casSymptomatology: caseReport.casSymptomatology,
      casPhysicalState: caseReport.casPhysicalState,
      casDiagnosis: caseReport.casDiagnosis,
      casStudyImg: caseReport.casStudyImg,
      casMethodOfEntry: caseReport.casMethodOfEntry,
      casActualRoom: caseReport.casActualRoom,
      casEntryArea: caseReport.casEntryArea,
    );
  }
}
