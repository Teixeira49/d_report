
import '../../../domain/entities/case_simple.dart';

abstract class MyCasesState {

}

class MyCasesInitial extends MyCasesState {}

class MyCasesLoaded extends MyCasesState {
  final List<CaseSimple> cases;
  MyCasesLoaded({required this.cases});
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