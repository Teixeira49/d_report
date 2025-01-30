import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/patient.dart';

abstract class FindPatientRepository {

  Future<Either<Failure, List<SearchPatient>>> searchPatients(String query, int searchKey, bool resetPage, String accessToken) ;

}