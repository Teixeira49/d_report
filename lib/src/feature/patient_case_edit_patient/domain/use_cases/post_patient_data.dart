import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/patient_edit_request.dart';
import '../repositories/patient_edit_reporitory.dart';

class PostPatientDataUseCase {

  PostPatientDataUseCase(this._caseEditRepository);

  final PatientEditRepository _caseEditRepository;

  Future<Either<Failure, PatientEditRequest>> call(String accessToken) async {
    try {
      var data = await _caseEditRepository.postPatientRequest(accessToken);
      return data.fold(
              (l) => Left(ServerFailure(l.message)),
              (r) => Right(r)
      );
    } catch (e) {
      return Left(LocalProcessFailure(e.toString()));
    }
  }
}
