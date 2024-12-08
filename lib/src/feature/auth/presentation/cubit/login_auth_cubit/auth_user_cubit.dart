import 'package:d_report/src/feature/auth/presentation/cubit/login_auth_cubit/auth_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/auth_user_repository_impl.dart';

class AuthCubit extends Cubit<AuthState> {

  final AuthRepositoryImpl _repositoryImpl;

  AuthCubit(this._repositoryImpl) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    try {
      emit(AuthLoading());
      final userAuth = await _repositoryImpl.login(username, password);
      print("pepe");
      final userProfile = await _repositoryImpl.getProfile(username, userAuth.accessToken);
      print("pasando");
      emit(AuthLoaded(userAuth, userProfile));
    } catch (e) {
      emit(AuthError('Error al subir los datos del paciente'));
    }
  }
}