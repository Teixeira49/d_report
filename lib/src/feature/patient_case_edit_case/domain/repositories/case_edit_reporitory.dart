import 'package:dartz/dartz.dart';
import '../../../../core/network/error/failures.dart';
import '../entities/case_report_edit_request.dart';


abstract class CaseEditRepository {

    Future<Either<Failure, CaseReportEditRequest>> postCaseRequest(String accessToken);
}