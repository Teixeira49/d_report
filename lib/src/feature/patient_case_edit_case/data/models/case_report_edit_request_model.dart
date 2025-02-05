
import '../../domain/entities/case_report_edit_request.dart';

class CaseReportEditRequestModel extends CaseReportEditRequest {

  CaseReportEditRequestModel({
    required super.casId,
    required super.patId,
    required super.casAdmissionReason,
    required super.casSymptomatology,
    required super.casPhysicalState,
    required super.casDiagnosis,
    required super.casMethodOfEntry,
    required super.casActualRoom,
    required super.casEntryArea,
    required super.casEndReason,
    required super.casEndDiagnosis,
  });

  factory CaseReportEditRequestModel.fromJson(json) {
    return CaseReportEditRequestModel(
        casId: json['casId'],
        patId: json['patId']['patId'],
        casAdmissionReason: json['casAdmissionReason'],
        casSymptomatology: json['casSymptomatology'],
        casPhysicalState: json['casPhysicalState'],
        casDiagnosis: json['casDiagnosis'],
        casMethodOfEntry: json['casMethodOfEntry'],
        casActualRoom: json['casActualRoom'],
        casEntryArea: json['casEntryArea'],
        casEndReason: json['casEndReason'],
        casEndDiagnosis: json['casEndDiagnosis']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "casId": casId,
      "patId": patId,
      "casAdmissionReason": casAdmissionReason,
      "casSymptomatology": casSymptomatology,
      "casPhysicalState": casPhysicalState,
      "casDiagnosis": casDiagnosis,
      "casMethodOfEntry": casMethodOfEntry,
      "casActualRoom": casActualRoom,
      "casEntryArea": casEntryArea,
      "casEndReason": casEndReason,
      "casEndDiagnosis": casEndDiagnosis
    };
  }

  Map<String, dynamic> toSubJson(int part) {
    switch (part) {
      case 0:
        return {
          "casId": casId,
          "casAdmissionReason": casAdmissionReason,
          "casSymptomatology": casSymptomatology,
          "casPhysicalState": casPhysicalState,
          "casDiagnosis": casDiagnosis,
        }; // "casStudyImg": casStudyImg,
      case 1:
        return {
          "casId": casId,
          "casActualRoom": casActualRoom,
          "casEntryArea": casEntryArea,
          "casMethodOfEntry": casMethodOfEntry,
        };
      case 2:
      return {
        "casId": casId,
        "casEndReason": casEndReason,
        "casEndDiagnosis": casEndDiagnosis
      };
      default:
        return toJson();
    }
  }

  factory CaseReportEditRequestModel.fromEntity(CaseReportEditRequest caseReportEditRequest) {
    return CaseReportEditRequestModel(
        casId: caseReportEditRequest.casId,
        patId: caseReportEditRequest.patId,
        casAdmissionReason: caseReportEditRequest.casAdmissionReason,
        casSymptomatology: caseReportEditRequest.casSymptomatology,
        casPhysicalState: caseReportEditRequest.casPhysicalState,
        casDiagnosis: caseReportEditRequest.casDiagnosis,
        casMethodOfEntry: caseReportEditRequest.casMethodOfEntry,
        casActualRoom: caseReportEditRequest.casActualRoom,
        casEntryArea: caseReportEditRequest.casEntryArea,
        casEndReason: caseReportEditRequest.casEndReason,
        casEndDiagnosis: caseReportEditRequest.casEndDiagnosis
    );
  }
}