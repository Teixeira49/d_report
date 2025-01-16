import 'package:dartz/dartz.dart';
import '../../../../core/network/error/failures.dart';
import '../entities/patient_edit_request.dart';


abstract class PatientEditRepository {

    Future<Either<Failure, PatientEditRequest>> postPatientRequest(PatientEditRequest patientEditRequest, int part, String accessToken);
}