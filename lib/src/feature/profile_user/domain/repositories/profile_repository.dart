import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/doctor.dart';

abstract class ProfileRepository {

  Future<Either<Failure, DoctorProfile>> getDoctorProfileById(int docId, String accessToken);

}

