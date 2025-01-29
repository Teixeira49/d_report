import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_button_state.dart';


class RegisterButtonCubit extends Cubit<RegisterButtonState> {

  RegisterButtonCubit() : super(RegisterButtonInitial());

  bool checkData(List<String?> rows, [bool blockSpacer = true]) {
    bool check = true;
    for (var i in rows) {
      if (i != null) {
        if (i.isEmpty || i == "" || (i.contains(' ') && blockSpacer)) {
          check = false;
          break;
        }
      } else {
        check = false;
        break;
      }
    }
    return check;
  }

  bool checkPassword(String password, String validatePassword){
    if (password == validatePassword && (password.isNotEmpty || password != "")) {
      return true;
    }
    return false;
  }

  Future<void> selectView(int currentState, ) async {
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
    selectView(currentState);
  }

}