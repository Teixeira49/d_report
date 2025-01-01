import 'package:d_report/src/core/network/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../shared/data/model/view_details_status.dart';
import '../../domain/entities/care_assignment.dart';
import '../../domain/entities/complete_report_dto.dart';
import '../../domain/repositories/case_repository.dart';
import '../datasource/remote/all_case_remote_data_source.dart';
import '../models/case_model.dart';
import '../models/patient_model.dart';

class PatientRepositoryImpl implements PatientRepository { //implements Repository {

  final AllCaseRemoteDataSource _patientDataRemoteDataSource;

  PatientRepositoryImpl(this._patientDataRemoteDataSource,);

  @override
  Future<Either<Failure, CompleteCaseDTO>> getPatientCaseData(casId, docId, accessToken) async {
    try {
      final patientCaseData = await _patientDataRemoteDataSource.getPatientData(casId, docId, accessToken);
      return Right(CompleteCaseDTO(
          comPatient: PatientModel.fromEntity(patientCaseData["pat"]),
          comCaseReport: CaseReportModel.fromEntity(patientCaseData["cas"]),
          viewDetailsStatus: ViewDetailsStatus.values[patientCaseData["permissionStatus"]]));
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }

  @override
  Future<Either<Failure, CareAssign>> endAssignment(
      int casId, int docId, String accessToken) async {
    try {
      final CareAssign resp = await _patientDataRemoteDataSource.endAssignment(casId, docId, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }

  @override
  Future<Either<Failure, CareAssign>> createAssignment(int casId, int docId, String accessToken) async {
    try {
      final CareAssign resp = await _patientDataRemoteDataSource.createAssignment(casId, docId, accessToken);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    }
  }
}