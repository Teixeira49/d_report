import '../../domain/entities/search_patients_dto.dart';

class PatientsResultsDTOModel extends PatientsResultsDTO {

  PatientsResultsDTOModel({
    required  super .listSearchPatient,
    required  super .isComplete,
    required  super .totalPatients,
  });

  factory PatientsResultsDTOModel.fromMixedJsonAndList(json, cases) {
    return PatientsResultsDTOModel(
      listSearchPatient: cases,
      isComplete: json['last'],
      totalPatients: json['totalElements'],
    );
  }
}