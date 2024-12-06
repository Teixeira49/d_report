
import '../../data/datasource/remote/new_follow_remote_datasource.dart';

class RepositoryImpl {
  const RepositoryImpl(this._followCaseRemoteDataSource);

  final FollowCaseRemoteDataSource _followCaseRemoteDataSource;

  Future<void> postPatientData(Map<String, dynamic> data) async {
    await _followCaseRemoteDataSource.postCaseFollowsByCase(data);
  }
}