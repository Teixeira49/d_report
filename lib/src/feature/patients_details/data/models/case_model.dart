import '../../domain/entities/case_report.dart';

class CaseReportModel extends CaseReport {

  CaseReportModel({
    required super .casId,
    required super .casEnterDate,
    required super .casSymptomatology,
    required super .casPhysicalState,
    required super .casDiagnosis,
    required super .casStudyImg,
    required super .casMethodOfEntry,
    required super .casActualRoom,
    required super .casEntryArea,
    required super .casEndFlag,
    required super .casEndDate,
    required super .casEndReason,
    required super .casEndDiagnosis,
    required super .patHeight,
    required super .patWeight,
  });

  factory CaseReportModel.fromJson(json) {

    return CaseReportModel(
        casId: json['caseReport']['casId'],
        casEnterDate: json['caseReport']['casEnterDate'],
        casSymptomatology: json['caseReport']['casSymptomatology'],
        casPhysicalState: json['caseReport']['casPhysicalState'],
        casDiagnosis: json['caseReport']['casDiagnosis'],
        casStudyImg: json['caseReport']['casStudyImg'],
        casMethodOfEntry: json['caseReport']['casMethodOfEntry'],
        casActualRoom: json['caseReport']['casActualRoom'],
        casEntryArea: json['caseReport']['casEntryArea'],
        casEndFlag: json['caseReport']['casEndFlag'],
        casEndDate: json['caseReport']['casEndDate'],
        casEndReason: json['caseReport']['casEndReason'],
        casEndDiagnosis: json['caseReport']['casEndDiagnosis'],
        patHeight: json['caseReport']['patHeight'],
        patWeight: json['caseReport']['patWeight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'casId': casId,
      'casEnterDate': casEnterDate,
      'casSymptomatology': casSymptomatology,
      'casPhysicalState': casPhysicalState,
      'casDiagnosis': casDiagnosis,
      'casStudyImg': casStudyImg,
      'casMethodOfEntry': casMethodOfEntry,
      'casActualRoom': casActualRoom,
      'casEntryArea': casEntryArea,
      'casEndFlag': casEndFlag,
      'casEndDate': casEndDate,
      'casEndReason': casEndReason,
      'casEndDiagnosis': casEndDiagnosis,
      'patHeight': patHeight,
      'patWeight': patWeight
    };
  }

  factory CaseReportModel.fromEntity(CaseReport caseReport) {
    return CaseReportModel(
      casId: caseReport.casId,
      casEnterDate: caseReport.casEnterDate,
      casSymptomatology: caseReport.casSymptomatology,
      casPhysicalState: caseReport.casPhysicalState,
      casDiagnosis: caseReport.casDiagnosis,
      casStudyImg: caseReport.casStudyImg,
      casMethodOfEntry: caseReport.casMethodOfEntry,
      casActualRoom: caseReport.casActualRoom,
      casEntryArea: caseReport.casEntryArea,
      casEndFlag: caseReport.casEndFlag,
      casEndDate: caseReport.casEndDate,
      casEndReason: caseReport.casEndReason,
      casEndDiagnosis: caseReport.casEndDiagnosis,
      patHeight: caseReport.patHeight,
      patWeight: caseReport.patWeight,
    );
  }
}