import '../../../../core/utils/constants/fields_constants.dart';
import '../../domain/entities/case_simple.dart';

class MyCasesModel extends CaseSimple {

  MyCasesModel({
    required  super .patName,
    required  super .casId,
    required  super .casActualRoom,
  });

  factory MyCasesModel.fromJson(json) {
    return MyCasesModel(
        patName: json['patId']['patName'] + space + json['patId']['patLastName'],
        casActualRoom: json['casActualRoom'],
        casId: json['casId'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      'casId': casId,
      'casActualRoom': casActualRoom,
      'patName': patName
    };
  }

  factory MyCasesModel.fromEntity(CaseSimple caseSimple) {
    return MyCasesModel(
        patName: caseSimple.patName,
        casId: caseSimple.casId,
        casActualRoom: caseSimple.casActualRoom
    );
  }
}