import '../../domain/entities/assigned_doctor.dart';

class AssignedDoctorModel extends AssignedDoctor {
  AssignedDoctorModel({
    required super.docId,
    required super.caaId,
    required super.docName,
    required super.docLastName,
    required super.docSpeciality,
    required super.caaStartDate,
    required super.caaEndDate,
    required super.caaPinned,
  });

  factory AssignedDoctorModel.fromJson(json) {
    return AssignedDoctorModel(
        docId: json['docId'],
        caaId: json['caaId'],
        docName: json['docName'],
        docLastName: json['docLastName'],
        docSpeciality: json['docSpeciality'],
        caaStartDate: json['caaStartDate'],
        caaEndDate: json['caaEndDate'],
        caaPinned: json['caaPinned']);
  }

  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'caaId': caaId,
      'docName': docName,
      'docLastName': docLastName,
      'docSpeciality': docSpeciality,
      'caaStartDate': caaStartDate,
      'caaEndDate': caaEndDate,
      'caaPinned': caaPinned,
    };
  }

  factory AssignedDoctorModel.fromEntity(AssignedDoctor assignedDoctor) {
    return AssignedDoctorModel(
      docId: assignedDoctor.docId,
      caaId: assignedDoctor.caaId,
      docName: assignedDoctor.docName,
      docLastName: assignedDoctor.docLastName,
      docSpeciality: assignedDoctor.docSpeciality,
      caaStartDate: assignedDoctor.caaStartDate,
      caaEndDate: assignedDoctor.caaEndDate,
      caaPinned: assignedDoctor.caaPinned,
    );
  }
}
