
import '../../../domain/entities/case_simple.dart';

abstract class MyCasesState {

}

class MyCasesInitial extends MyCasesState {}

class MyCasesLoading extends MyCasesState {
}

class MyCasesLoaded extends MyCasesState {
  final List<CaseSimple> cases;
  final String filter;
  MyCasesLoaded({required this.cases, this.filter = ''});

  MyCasesLoaded copyWith({List<CaseSimple>? cases, String? filter}) {
    print(this.filter);
    return MyCasesLoaded(
      cases: cases ?? this.cases,
      filter: filter ?? this.filter,
    );
  }
}

class MyCasesLoadedButEmpty extends MyCasesState {
  final String sms;
  MyCasesLoadedButEmpty({required this.sms});
}

class MyCasesTimeout extends MyCasesState {
  final String sms;
  MyCasesTimeout({required this.sms});
}

class MyCasesFail extends MyCasesState {
  final String errorSMS;
  MyCasesFail({required this.errorSMS});
}
