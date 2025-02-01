import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/search_patients_dto.dart';

abstract class FindPatientRepository {

  Future<Either<Failure, PatientsResultsDTO>> searchPatients(String query, int searchKey, bool resetPage, String accessToken) ;

}