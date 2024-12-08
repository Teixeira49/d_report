
import '../../../domain/entities/case_simple.dart';

abstract class FindCasesState {

}

class FindCasesInitial extends FindCasesState {}

class FindCasesLoaded extends FindCasesState {
  final List<CaseSimple> cases;
  FindCasesLoaded({required this.cases});
}

class FindCasesLoadedButEmpty extends FindCasesState {
  final String sms;
  FindCasesLoadedButEmpty({required this.sms});
}

class FindCasesFail extends FindCasesState {
  final String errorSMS;
  FindCasesFail({required this.errorSMS});
}