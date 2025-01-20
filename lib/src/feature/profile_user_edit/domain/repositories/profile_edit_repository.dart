import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/doctor.dart';

abstract class ProfileEditRepository {

  Future<Either<Failure, Doctor>> putDoctorProfile(int docId, String accessToken);

}