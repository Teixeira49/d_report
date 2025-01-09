
class FollowDetailedCase{

  FollowDetailedCase(
      {
        required this.cafId,
        required this.casId,
        required this.cafReportType,
        required this.cafReportInfo,
        required this.cafReportDate,
        required this.docFullName,
        required this.docSpecialty,
        required this.cafReportTitle,
        required this.cafReportUpdateTime,
      }
      );

  int cafId;
  int casId;
  String cafReportType;
  String cafReportInfo;
  String cafReportDate;
  String docFullName;
  String docSpecialty;
  String cafReportTitle;
  String cafReportUpdateTime;
}