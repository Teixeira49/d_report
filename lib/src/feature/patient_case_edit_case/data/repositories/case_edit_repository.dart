import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/error/failures.dart';
import '../../domain/entities/case_report_edit_request.dart';
import '../../domain/repositories/case_edit_reporitory.dart';
import '../datasource/remote/case_edit_request_remote_data_source.dart';


class CaseEditRepositoryImpl implements CaseEditRepository {
  const CaseEditRepositoryImpl(this._caseEditRequestRemoteDataSource);

  final CaseEditRequestRemoteDataSource _caseEditRequestRemoteDataSource; // TOOD Sospecho esto va en el normal y no en el Impl

  @override
  Future<Either<Failure, CaseReportEditRequest>> postCaseRequest(CaseReportEditRequest caseReportEditRequest, int part, String accessToken) async {

    try {
      final caseReportData = await _caseEditRequestRemoteDataSource.postCaseEditRequest(caseReportEditRequest, part, accessToken);
      return Right(caseReportData);
    } on DioException {
      return Left(ServerFailure("Fallo en conexion al servidor"));
    } catch (e) {
      return Left(OtherFailure("Fallo recibiendo actualizacion"));
    }
  }
}