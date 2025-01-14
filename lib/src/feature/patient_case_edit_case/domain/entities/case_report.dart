
class CaseReport{

  CaseReport(
      {
        required this.casId,
        required this.casSymptomatology,
        required this.casPhysicalState,
        required this.casDiagnosis,
        required this.casStudyImg,
        required this.casMethodOfEntry,
        required this.casActualRoom,
        required this.casEntryArea,
        required this.casEndFlag,
        required this.casEndReason,
        required this.casEndDiagnosis,
      }
    );

  int casId;
  String casSymptomatology;
  String casPhysicalState;
  String casDiagnosis;
  String? casStudyImg;
  String casMethodOfEntry;
  String casActualRoom;
  String casEntryArea;
  bool? casEndFlag;
  String? casEndReason;
  String? casEndDiagnosis;
}