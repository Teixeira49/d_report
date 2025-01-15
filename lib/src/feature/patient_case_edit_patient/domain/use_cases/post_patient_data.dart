import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/patient_edit_request.dart';
import '../repositories/patient_edit_reporitory.dart';

class PostPatientDataUseCase {

  PostPatientDataUseCase(this._patientEditRepository);

  final PatientEditRepository _patientEditRepository;

  Future<Either<Failure, PatientEditRequest>> call(PatientEditRequest patientEditRequest, int part, String accessToken) async {
    try {
      var data = await _patientEditRepository.postPatientRequest(patientEditRequest, part, accessToken);
      return data.fold(
              (l) => Left(ServerFailure(l.message)),
              (r) => Right(r)
      );
    } catch (e) {
      return Left(LocalProcessFailure(e.toString()));
    }
  }
}
