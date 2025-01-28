
import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../../../shared/domain/entities/doctor.dart';
import '../../data/repositories/profile_edit_repository_impl.dart';
import '../entities/profile_doctor_request.dart';

class PostProfileDataUseCase {

  PostProfileDataUseCase(this._profileEditRepositoryImpl);

  final ProfileEditRepositoryImpl _profileEditRepositoryImpl;

  Future<Either<Failure, DoctorProfile>> call(DoctorProfileRequest doctorEditRequest, String email, String accessToken) async {
    try {
      var data = await _profileEditRepositoryImpl.putDoctorProfile(doctorEditRequest, email, accessToken);
      return data.fold(
              (l) => Left(ServerFailure(l.message)),
              (r) => Right(r)
      );
    } catch (e) {
      return Left(LocalProcessFailure(e.toString()));
    }
  }
}