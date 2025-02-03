import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/patient.dart';

abstract class NewPatientCaseRepository {

  Future<Either<Failure, String>> checkIfPatientExist(String patName, String patLastName, int patGuardianDni, String accessToken, [int? patDni]);

  Future<Either<Failure, Patient>> createPatient(Map<String, dynamic> patientData, String accessToken);

}

