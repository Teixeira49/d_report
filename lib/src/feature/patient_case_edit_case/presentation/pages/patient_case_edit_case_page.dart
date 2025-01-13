import 'package:d_report/src/feature/patient_case_edit_case/presentation/cubit/select_editor/case_editor_select_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasource/remote/case_edit_request_remote_data_source.dart';
import '../../data/repositories/case_edit_repository.dart';
import '../../domain/use_cases/post_case_data.dart';
import '../cubit/case_editor/case_editor_cubit.dart';
import '../cubit/case_editor/case_editor_state.dart';
import '../cubit/select_editor/case_editor_select_cubit.dart';
import '../widgets/data_textArea.dart';
import '../widgets/data_textField.dart';
import '../widgets/entry_area_field.dart';
import '../widgets/floor_field.dart';
import '../widgets/next_state_button.dart';

class EditCaseCasePage extends StatefulWidget {
  const EditCaseCasePage({super.key});

  @override
  MyEditCaseCaseState createState() => MyEditCaseCaseState();
}


class MyEditCaseCaseState extends State<EditCaseCasePage> {

  late final int initialPage;

  late final PageController _pageController;

  final ValueNotifier<String?> _roomValueController = ValueNotifier<String?>(null);
  final TextEditingController _roomNumberController = TextEditingController();
  final TextEditingController _symptomatologyController = TextEditingController();
  final TextEditingController _reasonConsultationController = TextEditingController();
  final TextEditingController _physicalStateController = TextEditingController();
  final TextEditingController _diagnosisController = TextEditingController();
  final ValueNotifier<String?> _entryAreaController = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _referralController = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies(){
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    initialPage = (args['id'] != null) ? args['id'] : 1;
    _pageController = PageController(
      initialPage: initialPage
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _roomValueController.dispose();
    _roomNumberController.dispose();
    _symptomatologyController.dispose();
    _reasonConsultationController.dispose();
    _physicalStateController.dispose();
    _diagnosisController.dispose();
    _entryAreaController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final CaseEditRequestRemoteDataSourceImpl caseEditRequestRemoteDataSource =
        CaseEditRequestRemoteDataSourceImpl();
    final CaseEditRepositoryImpl caseEditRepository =
        CaseEditRepositoryImpl(caseEditRequestRemoteDataSource);
    final PostCaseDateUseCase postCaseDateUseCase =
        PostCaseDateUseCase(caseEditRepository);

    dynamic arguments = ModalRoute.of(context)!.settings.arguments;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CaseEditorCubit(postCaseDateUseCase)),
        BlocProvider(create: (_) => CaseEditorSelectCubit()..onModifySelection(arguments['title'].toString().toLowerCase()))
      ],
      child: BlocListener<CaseEditorCubit, CaseEditorState> (
        listener: (contextCaseEditor, stateCaseEditor) {

        },
        child: BlocBuilder<CaseEditorSelectCubit, CaseEditorSelectState> (
          builder: (contextSelector, stateSelector) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Editar ${BlocProvider.of<CaseEditorSelectCubit>(contextSelector).getSelection()}'),
              ),
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: size.height * 0.25,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(height: 24,), // TODO Make a global Widget
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: Text(
                                    "Descripcion de Enfermedad del paciente",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: CaseDataTextField(
                                    contextRow: 'Motivo de Consulta',
                                    controllerData: _reasonConsultationController,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: CaseDataTextArea(
                                    contextRow: 'Sintomatologia',
                                    controllerData: _symptomatologyController,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: CaseDataTextArea(
                                    contextRow: 'Estado Fisico',
                                    controllerData: _physicalStateController,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: CaseDataTextField(
                                    contextRow: 'Diagnostico Inicial',
                                    controllerData: _diagnosisController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: size.height * 0.25,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 24,), // TODO Make a global Widget
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: Text(
                                    "Descripcion de Enfermedad del paciente",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.075,
                                      vertical: size.height * 0.010,
                                    ),
                                    child: FloorMixedField(
                                      controllerDataDropDown:
                                      _roomValueController,
                                      controllerDataTextField:
                                      _roomNumberController,
                                    )),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.075,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: EntryAreaDropdownField(
                                      controllerData: _entryAreaController),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Text('a'),
                    ],
                  ),

                  Positioned(
                      bottom: 50,
                      child: FetchUpdateButton(size: size, selected: 0, endFindPatient: () {  },)),
                  //Text('No se que poner aqui')
                ],
              ),
            );
          }
        )
      )
    );
  }
}
