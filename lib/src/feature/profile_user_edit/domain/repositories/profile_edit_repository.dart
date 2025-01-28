import 'package:d_report/src/feature/profile_user_edit/domain/entities/profile_doctor_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../../../shared/domain/entities/doctor.dart';

abstract class ProfileEditRepository {

  Future<Either<Failure, DoctorProfile>> putDoctorProfile(DoctorProfileRequest profileRequest, String accessToken);

}