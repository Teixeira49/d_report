import 'package:dartz/dartz.dart';
import '../../../../core/network/error/failures.dart';
import '../entities/patient_guardian_edit_request.dart';

abstract class PatientGuardianEditRepository {
  Future<Either<Failure, PatientGuardianEditRequest>> postPatGuardianRequest(
      PatientGuardianEditRequest patientGuardianEditRequest,
      String accessToken);
}
