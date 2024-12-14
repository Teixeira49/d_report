import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/care_assignment.dart';
import '../entities/complete_report_dto.dart';

abstract class PatientRepository {

  Future<Either<Failure, CompleteCaseDTO>> getPatientCaseData(int casId, String accessToken);

  Future<Either<Failure, CareAssign>> endAssignment(int casId, int docId, String accessToken);

}