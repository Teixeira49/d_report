import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/patient.dart';

abstract class NewPatientCaseRepository {

  Future<Either<Failure, String>> checkIfPatientExist(String patName, String patLastName, int patGuardianDni, String accessToken);

  Future<Either<Failure, Patient>> createPatient(Map<String, dynamic> patientData, String accessToken);

}

