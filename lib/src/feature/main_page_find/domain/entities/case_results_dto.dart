import 'case_simple.dart';

class  CaseResultsDTO  {
  final List<CaseSimple> listCasesSimple;
  final bool isComplete;
  final int totalCases;

  CaseResultsDTO(
      {
        required  this .listCasesSimple,
        required  this .isComplete,
        required  this .totalCases,
      }
      );
}