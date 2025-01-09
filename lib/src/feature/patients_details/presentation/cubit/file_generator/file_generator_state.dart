import 'package:pdf/widgets.dart' as pw;

abstract class FileGeneratorState {

}

class FileGeneratorInitial extends FileGeneratorState {}

class FileGeneratorLoading extends FileGeneratorState {}

class FileGeneratorLoaded extends FileGeneratorState {
  final pw.Document pdf;
  FileGeneratorLoaded({required this.pdf});
}

class FileGeneratorTimeout extends FileGeneratorState {
  final String sms;
  FileGeneratorTimeout({required this.sms});
}

class FileGeneratorFail extends FileGeneratorState {
  final String errorSMS;
  FileGeneratorFail({required this.errorSMS});
}