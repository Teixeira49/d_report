
import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';


abstract class AuthRepository {

  Future<AuthUser> login(String email, String password );

  Future<User> getProfile(String email, String accessToken);

}