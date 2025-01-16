import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/entities/patient_guardian_edit_request.dart';
import '../../domain/repositories/patient_guardian_edit_reporitory.dart';
import '../datasource/remote/patient_guardian_edit_request_remote_data_source.dart';

class PatientGuardianEditRepositoryImpl
    implements PatientGuardianEditRepository {
  const PatientGuardianEditRepositoryImpl(
      this._patientGuardianEditRequestRemoteDataSource);

  final PatientGuardianEditRequestRemoteDataSource
      _patientGuardianEditRequestRemoteDataSource; // TOOD Sospecho esto va en el normal y no en el Impl

  @override
  Future<Either<Failure, PatientGuardianEditRequest>> postPatGuardianRequest(
      PatientGuardianEditRequest patientGuardianEditRequest,
      String accessToken) async {
    try {
      final patGuardianData = await _patientGuardianEditRequestRemoteDataSource
          .postPatientGuardianEditRequest(
              patientGuardianEditRequest, accessToken);
      return Right(patGuardianData);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    } catch (e) {
      return Left(OtherFailure("Fallo recibiendo datos del servidor"));
    }
  }
}
