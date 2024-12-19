import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_button_state.dart';


class RegisterButtonCubit extends Cubit<RegisterButtonState> {

  RegisterButtonCubit() : super(RegisterButtonInitial());

  Future<void> selectOperation(int currentState, ) async {
    try {
      emit(RegisterButtonLoading());
      if (currentState < 3) {
        emit(RegisterButtonLoaded('Siguiente Paso'));
      } else if (currentState >= 3) {
        emit(RegisterButtonLoaded('Finalizar Registro'));
      }
    } catch (e) {
      emit(RegisterButtonError('Error en proceso de registro, intente mas tarde'));
    }
  }

  void forceUpdateCubit(int currentState, ) {
    selectOperation(currentState);
  }

}