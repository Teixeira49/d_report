class CaseReportEditRequest {
  CaseReportEditRequest({
    required this.casId,
    required this.patId,
    required this.casSymptomatology,
    required this.casPhysicalState,
    required this.casDiagnosis,
    required this.casMethodOfEntry,
    required this.casActualRoom,
    required this.casEntryArea,
    required this.casEndReason,
    required this.casEndDiagnosis,
  });

  int casId;
  int patId;
  String casSymptomatology;
  String casPhysicalState;
  String casDiagnosis;
  String casMethodOfEntry;
  String casActualRoom;
  String casEntryArea;
  String? casEndReason;
  String? casEndDiagnosis;
}
