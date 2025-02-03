
class  CaseSimple  {
  final String patName;
  final String casId;
  final String casActualRoom;
  final bool casEndFlag;
  final String? casEndReason;
  //final String casMethodOfEntry;
  //final String casEntryArea;

  CaseSimple(
      {
        required  this .patName,
        required  this .casId,
        required  this .casActualRoom,
        required  this .casEndFlag,
        required  this .casEndReason,
      }
    );
}