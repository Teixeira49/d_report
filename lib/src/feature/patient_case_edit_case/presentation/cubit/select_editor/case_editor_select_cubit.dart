import 'package:flutter_bloc/flutter_bloc.dart';

import 'case_editor_select_state.dart';

class CaseEditorSelectCubit extends Cubit<CaseEditorSelectState> {
  CaseEditorSelectCubit() : super(CaseEditorSelectRows());

  void onModifySelection(String title) {
    emit(state.copyWith(newTitle: title));
  }

  String getSelection() {
    if (state is CaseEditorSelectRows) {
      return state.getSelection();
    }
    return '';
  }
}
