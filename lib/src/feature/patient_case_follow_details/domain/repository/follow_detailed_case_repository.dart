
import '../../data/datasource/remote/follow_case_remote_data_source.dart';
import '../../domain/entities/follows_detailed_case.dart';

//abstract class Repository {
//  Future<Patient> getPatientData(int casId);
//}

class FollowDetailedRepositoryImpl { //implements Repository {
  const FollowDetailedRepositoryImpl(this._followDetailedCaseRemoteDataSource);

  final FollowCaseDetailsRemoteDataSource _followDetailedCaseRemoteDataSource;

  Future<FollowDetailedCase> getCaseFollowsByCase(cafId, accessToken) async {
    return await _followDetailedCaseRemoteDataSource.getCaseFollowsByCase(cafId, accessToken);
  }
}