
import '../../domain/entities/follows_in_case.dart';
import '../datasource/remote/follow_case_remote_data_source.dart';

//abstract class Repository {
//  Future<Patient> getPatientData(int casId);
//}

class FollowRepositoryImpl { //implements Repository {
  const FollowRepositoryImpl(this._followCaseRemoteDataSource);

  final FollowCaseRemoteDataSource _followCaseRemoteDataSource;

  Future<List<FollowCase>> getCaseFollowsByCase(casId, accessToken) async {
    return await _followCaseRemoteDataSource.getCaseFollowsByCase(casId, accessToken);
  }
}