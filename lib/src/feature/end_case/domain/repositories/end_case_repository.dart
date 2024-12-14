
import 'package:d_report/src/feature/end_case/domain/entities/end_case_dto.dart';
import 'package:d_report/src/shared/domain/entities/case_report.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';

abstract class EndCaseRepository {

  Future<Either<Failure, CaseReport>> endSelectedCase(EndCaseDTO endCaseDTO, String accessToken);
}