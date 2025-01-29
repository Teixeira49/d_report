import 'package:d_report/src/core/helpers/helpers.dart';
import '../../domain/entities/add_case.dart';

class NewCaseReportModel extends NewCaseReport {
  NewCaseReportModel({
    required super.docId,
    required super.casAdmissionReason,
    required super.casSymptomatology,
    required super.casPhysicalState,
    required super.casDiagnosis,
    required super.casMethodOfEntry,
    required super.casActualRoom,
    required super.casEntryArea,
  });

  factory NewCaseReportModel.fromJson(json) {
    return NewCaseReportModel(
      docId: json['docId'],
      casAdmissionReason: json['casAdmissionReason'],
      casSymptomatology: json['casSymptomatology'],
      casPhysicalState: json['casPhysicalState'],
      casDiagnosis: json['casDiagnosis'],
      casMethodOfEntry: json['casMethodOfEntry'],
      casActualRoom: json['casActualRoom'],
      casEntryArea: json['casEntryArea'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'casAdmissionReason': casAdmissionReason,
      'casSymptomatology': casSymptomatology,
      'casPhysicalState': casPhysicalState,
      'casDiagnosis': casDiagnosis,
      'casMethodOfEntry': casMethodOfEntry,
      'casActualRoom': casActualRoom,
      'casEntryArea': casEntryArea,
    };
  }

  factory NewCaseReportModel.fromEntity(NewCaseReport caseReport) {
    return NewCaseReportModel(
      docId: caseReport.docId,
      casAdmissionReason: caseReport.casAdmissionReason,
      casSymptomatology: caseReport.casSymptomatology,
      casPhysicalState: caseReport.casPhysicalState,
      casDiagnosis: caseReport.casDiagnosis,
      casMethodOfEntry: caseReport.casMethodOfEntry,
      casActualRoom: caseReport.casActualRoom,
      casEntryArea: caseReport.casEntryArea,
    );
  }
}
