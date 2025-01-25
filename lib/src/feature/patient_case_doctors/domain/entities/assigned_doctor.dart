class AssignedDoctor {

  AssignedDoctor({
    required this.docId,
    required this.caaId,
    required this.docName,
    required this.docLastName,
    required this.docSpeciality,
    required this.caaStartDate,
    required this.caaEndDate,
    required this.caaPinned,
});

  int docId;
  int caaId;
  String docName;
  String docLastName;
  String docSpeciality;
  String caaStartDate; // TODO CHANGE to Datetime
  String caaEndDate;
  bool caaPinned;

}