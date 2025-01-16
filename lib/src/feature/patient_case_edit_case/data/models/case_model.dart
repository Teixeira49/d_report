import '../../domain/entities/case_report.dart';

class CaseReportModel extends CaseReport {

  CaseReportModel({
    required super .casId,
    required super .casSymptomatology,
    required super .casPhysicalState,
    required super .casDiagnosis,
    required super .casStudyImg,
    required super .casMethodOfEntry,
    required super .casActualRoom,
    required super .casEntryArea,
    required super .casEndFlag,
    required super .casEndReason,
    required super .casEndDiagnosis,
  });

  factory CaseReportModel.fromJson(json) {

    return CaseReportModel(
        casId: json['casId'],
        casSymptomatology: json['casSymptomatology'],
        casPhysicalState: json['casPhysicalState'],
        casDiagnosis: json['casDiagnosis'],
        casStudyImg: json['casStudyImg'],
        casMethodOfEntry: json['casMethodOfEntry'],
        casActualRoom: json['casActualRoom'],
        casEntryArea: json['casEntryArea'],
        casEndFlag: json['casEndFlag'],
        casEndReason: json['casEndReason'],
        casEndDiagnosis: json['casEndDiagnosis'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'casId': casId,
      'casSymptomatology': casSymptomatology,
      'casPhysicalState': casPhysicalState,
      'casDiagnosis': casDiagnosis,
      'casStudyImg': casStudyImg,
      'casMethodOfEntry': casMethodOfEntry,
      'casActualRoom': casActualRoom,
      'casEntryArea': casEntryArea,
      'casEndFlag': casEndFlag,
      'casEndReason': casEndReason,
      'casEndDiagnosis': casEndDiagnosis,
    };
  }

  factory CaseReportModel.fromEntity(CaseReport caseReport) {
    return CaseReportModel(
      casId: caseReport.casId,
      casSymptomatology: caseReport.casSymptomatology,
      casPhysicalState: caseReport.casPhysicalState,
      casDiagnosis: caseReport.casDiagnosis,
      casStudyImg: caseReport.casStudyImg,
      casMethodOfEntry: caseReport.casMethodOfEntry,
      casActualRoom: caseReport.casActualRoom,
      casEntryArea: caseReport.casEntryArea,
      casEndFlag: caseReport.casEndFlag,
      casEndReason: caseReport.casEndReason,
      casEndDiagnosis: caseReport.casEndDiagnosis,
    );
  }
}