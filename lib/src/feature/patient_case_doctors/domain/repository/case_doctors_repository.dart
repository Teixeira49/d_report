import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/assigned_doctor.dart';

abstract class CaseDoctorRepository {

  Future<Either<Failure, List<AssignedDoctor>>> getDoctorsInCase(int casId, String accessToken);
}