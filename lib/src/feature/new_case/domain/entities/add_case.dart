class NewCaseReport {
  NewCaseReport({
    required this.docId,
    required this.casSymptomatology,
    required this.casPhysicalState,
    required this.casDiagnosis,
    required this.casStudyImg,
    required this.casMethodOfEntry,
    required this.casActualRoom,
    required this.casEntryArea,
  });

  final int docId;
  String casSymptomatology;
  String casPhysicalState;
  String casDiagnosis;
  String? casStudyImg;
  String casMethodOfEntry;
  String casActualRoom;
  String casEntryArea;
}
