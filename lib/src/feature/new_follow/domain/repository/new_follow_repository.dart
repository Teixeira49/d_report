
import '../../data/datasource/remote/new_follow_remote_datasource.dart';

class FollowCaseRepositoryImpl {
  const FollowCaseRepositoryImpl(this._followCaseRemoteDataSource);

  final FollowCaseRemoteDataSource _followCaseRemoteDataSource;

  Future<void> postFollowCaseData(Map<String, dynamic> data, String accessToken) async {
    await _followCaseRemoteDataSource.postCaseFollowsByCase(data, accessToken);
  }
}