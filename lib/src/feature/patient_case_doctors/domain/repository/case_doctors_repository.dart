import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/view_doctors.dart';

abstract class CaseDoctorRepository {

  Future<Either<Failure, ViewDoctors>> getDoctorsInCase(int casId, String accessToken);
}