abstract class CaseEditorSelectState {
  CaseEditorSelectState copyWith({required String newTitle});

  String getSelection();
}

class CaseEditorSelectRows extends CaseEditorSelectState {
  final String title;

  CaseEditorSelectRows({this.title = ''});

  @override
  CaseEditorSelectRows copyWith({String? newTitle}) {
    return CaseEditorSelectRows(title: newTitle ?? title);
  }

  @override
  String getSelection() {
    return title;
  }
}
