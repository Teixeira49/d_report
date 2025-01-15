import 'package:d_report/src/feature/patient_case_edit_patient_guardian/domain/entities/patient_guardian_edit_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../repositories/patient_guardian_edit_reporitory.dart';

class PostPatientGuardianDateUseCase {

  PostPatientGuardianDateUseCase(this._patientGuardianEditRepository);

  final PatientGuardianEditRepository _patientGuardianEditRepository;

  Future<Either<Failure, PatientGuardianEditRequest>> call(PatientGuardianEditRequest patientGuardianEditRequest, String accessToken) async {
    try {
      var data = await _patientGuardianEditRepository.postPatGuardianRequest(patientGuardianEditRequest, accessToken);
      return data.fold(
              (l) => Left(ServerFailure(l.message)),
              (r) => Right(r)
      );
    } catch (e) {
      return Left(LocalProcessFailure(e.toString()));
    }
  }
}
