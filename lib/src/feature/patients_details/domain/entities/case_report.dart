
class CaseReport{

  CaseReport(
      {
        required this.casId,
        required this.casEnterDate,
        required this.casSymptomatology,
        required this.casPhysicalState,
        required this.casDiagnosis,
        required this.casStudyImg,
        required this.casMethodOfEntry,
        required this.casActualRoom,
        required this.casEntryArea,
        required this.casEndFlag,
        required this.casEndDate,
        required this.casEndReason,
        required this.casEndDiagnosis,
      }
    );

  int casId;
  String casEnterDate;
  String casSymptomatology;
  String casPhysicalState;
  String casDiagnosis;
  String? casStudyImg;
  String casMethodOfEntry;
  String casActualRoom;
  String casEntryArea;
  bool? casEndFlag;
  String? casEndDate;
  String? casEndReason;
  String? casEndDiagnosis;
}