class NewCaseReport {
  NewCaseReport({
    required this.docId,
    required this.casAdmissionReason,
    required this.casSymptomatology,
    required this.casPhysicalState,
    required this.casDiagnosis,
    required this.casMethodOfEntry,
    required this.casActualRoom,
    required this.casEntryArea,
  });

  final int docId;
  String casAdmissionReason;
  String casSymptomatology;
  String casPhysicalState;
  String casDiagnosis;
  String casMethodOfEntry;
  String casActualRoom;
  String casEntryArea;
}
