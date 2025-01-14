import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/case_report_edit_request.dart';
import '../repositories/case_edit_reporitory.dart';

class PostCaseDateUseCase {

  PostCaseDateUseCase(this._caseEditRepository);

  final CaseEditRepository _caseEditRepository;

  Future<Either<Failure, CaseReportEditRequest>> call(String accessToken) async {
    try {
      var data = await _caseEditRepository.postCaseRequest(accessToken);
      return data.fold(
              (l) => Left(ServerFailure(l.message)),
              (r) => Right(r)
      );
    } catch (e) {
      return Left(LocalProcessFailure(e.toString()));
    }
  }
}
