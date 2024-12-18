import 'package:d_report/src/shared/domain/entities/case_report.dart';
import 'package:d_report/src/core/helpers/helpers.dart';

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
  });

  factory CaseReportModel.fromJson(json) {

    var finishEnterDate = Helper.getDateSMSByString(json['casEnterDate']);
    var finishEndDate = json['casEndDate'] != null ? Helper.getDateSMSByString(json['casEndDate']) : null;

    return CaseReportModel(
        casId: json['casId'],
        casEnterDate: finishEnterDate,
        casSymptomatology: json['casSymptomatology'],
        casPhysicalState: json['casPhysicalState'],
        casDiagnosis: json['casDiagnosis'],
        casStudyImg: json['casStudyImg'],
        casMethodOfEntry: json['casMethodOfEntry'],
        casActualRoom: json['casActualRoom'],
        casEntryArea: json['casEntryArea'],
        casEndFlag: json['casEndFlag'],
        casEndDate: finishEndDate,
        casEndReason: json['casEndReason'],
        casEndDiagnosis: json['casEndDiagnosis'],
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
      'casEndDiagnosis': casEndDiagnosis
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
      casEndDiagnosis: caseReport.casEndDiagnosis
    );
  }
}