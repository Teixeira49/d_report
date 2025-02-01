import 'patient.dart';

class  PatientsResultsDTO  {
  final List<SearchPatient> listSearchPatient;
  final bool isComplete;
  final int totalPatients;

  PatientsResultsDTO(
      {
        required  this .listSearchPatient,
        required  this .isComplete,
        required  this .totalPatients,
      }
      );
}