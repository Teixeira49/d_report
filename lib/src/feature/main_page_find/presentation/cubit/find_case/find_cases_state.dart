
import '../../../domain/entities/case_simple.dart';

abstract class FindCasesState {

}

class FindCasesInitial extends FindCasesState {}

class FindCasesLoading extends FindCasesState {}

class FindCasesLoaded extends FindCasesState {
  final List<CaseSimple> cases;
  final String filter;

  FindCasesLoaded({required this.cases, this.filter = ''});

  FindCasesLoaded copyWith({List<CaseSimple>? cases, String? filter}) {
    return FindCasesLoaded(
      cases: cases ?? this.cases,
      filter: filter ?? this.filter,
    );
  }
}

class FindCasesLoadedButEmpty extends FindCasesState {
  final String sms;
  FindCasesLoadedButEmpty({required this.sms});
}

class FindCasesTimeout extends FindCasesState {}

class FindCasesFail extends FindCasesState {
  final String errorSMS;
  FindCasesFail({required this.errorSMS});
}