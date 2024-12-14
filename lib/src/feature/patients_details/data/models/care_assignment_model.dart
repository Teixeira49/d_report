import '../../domain/entities/care_assignment.dart';

class CareAssignModel extends CareAssign {

  CareAssignModel({
    required  super .casId,
    required  super .docId,
    required  super .caaPinned,
    required  super .caaStartDate,
    required  super .caaEndDate,
  });

  factory CareAssignModel.fromJson(json) {
    return CareAssignModel(
      casId: json['casId'],
      docId: json['docId'],
      caaPinned: json['caaPinned'],
      caaStartDate: json['caaStartDate'],
      caaEndDate: json['caaEndDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'casId': casId,
      'docId': docId,
      'caaPinned': caaPinned,
      'caaStartDate': caaStartDate,
      'caaEndDate': caaEndDate,
    };
  }

  factory CareAssignModel.fromEntity(CareAssign careAssign) {
    return CareAssignModel(
      casId: careAssign.casId,
      docId: careAssign.docId,
      caaPinned: careAssign.caaPinned,
      caaStartDate: careAssign.caaStartDate,
      caaEndDate: careAssign.caaEndDate,
    );
  }
}