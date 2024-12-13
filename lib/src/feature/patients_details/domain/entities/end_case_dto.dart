

class EndCaseDTO{

  EndCaseDTO(
      {
        required this.encPatId,
        required this.encCasId,
        required this.encEndReason,
      }
      );

  String encEndReason;
  int encPatId;
  int encCasId;
}