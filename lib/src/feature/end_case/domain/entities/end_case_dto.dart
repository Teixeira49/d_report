

class EndCaseDTO{

  EndCaseDTO(
      {
        required this.encPatId,
        required this.encCasId,
        required this.encEndReason,
        required this.encEndDiagnosis
      }
      );

  String encEndReason;
  int encPatId;
  int encCasId;
  String encEndDiagnosis;
}