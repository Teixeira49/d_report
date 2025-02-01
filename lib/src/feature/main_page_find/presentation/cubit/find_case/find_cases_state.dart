
import '../../../domain/entities/case_simple.dart';

abstract class FindCasesState {}

class FindCasesInitial extends FindCasesState {}

class FindCasesLoading extends FindCasesState {}

class FindCasesLoaded extends FindCasesState {
  final List<CaseSimple> cases;
  final String filter;
  final bool isComplete;
  FindCasesLoaded({required this.cases, this.filter = '', this.isComplete = false});

  FindCasesLoaded copyWith({List<CaseSimple>? newCases, String? filter, bool? isComplete}) {
    return FindCasesLoaded(
      cases: newCases != null ? [...cases, ...newCases]: cases,
      filter: filter ?? this.filter,
      isComplete: isComplete ?? this.isComplete,
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