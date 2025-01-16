import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/error/failures.dart';

import '../../domain/entities/patient_edit_request.dart';
import '../../domain/repositories/patient_edit_reporitory.dart';

import '../datasource/remote/patient_edit_request_remote_data_source.dart';


class PatientEditRepositoryImpl implements PatientEditRepository {
  const PatientEditRepositoryImpl(this._patientEditRequestRemoteDataSource);

  final PatientEditRequestRemoteDataSource _patientEditRequestRemoteDataSource; // TOOD Sospecho esto va en el normal y no en el Impl

  @override
  Future<Either<Failure, PatientEditRequest>> postPatientRequest(PatientEditRequest patientEditRequest, int part, String accessToken) async {

    try {
      final caseReportData = await _patientEditRequestRemoteDataSource.postPatientEditRequest(patientEditRequest, part, accessToken);
      return Right(caseReportData);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    } catch (e) {
      return Left(OtherFailure("Fallo en conexion al servidor"));
    }
  }
}