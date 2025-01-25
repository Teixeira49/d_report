import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/assigned_doctor.dart';
import '../repository/case_doctors_repository.dart';

class FetchDoctorsUseCase {

  final CaseDoctorRepository _caseDoctorRepository;

  FetchDoctorsUseCase(this._caseDoctorRepository);

  Future<Either<Failure, List<AssignedDoctor>>> call(int casId, String accessToken) async {
    try {
      var data = await _caseDoctorRepository.getDoctorsInCase(casId, accessToken);
      return data.fold(
          (l) => Left(ServerFailure(l.message)),
          (r) => Right(r),
      );
    } catch (e) {
      return Left(LocalProcessFailure(e.toString()));
    }
  }
}