import 'package:d_report/src/feature/new_case/domain/entities/add_case.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../../../shared/domain/entities/case_report.dart';
import '../entities/patient.dart';

abstract class NewCaseRepository {

  Future<Either<Failure, CaseReport>> createCaseByNewPatient(Patient patData, NewCaseReport casData, String accessToken);

  Future<Either<Failure, CaseReport>> createCaseByOldPatient(int patData, NewCaseReport casData, String accessToken);

}

