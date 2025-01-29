import 'package:d_report/src/feature/patient_case_edit_case/presentation/cubit/select_editor/case_editor_select_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/fields_constants.dart';
import '../../../../shared/domain/entities/auth_user.dart';

import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../../../../shared/presentation/widget/loading_show_dialog.dart';
import '../../data/datasource/remote/case_edit_request_remote_data_source.dart';
import '../../data/models/case_report_edit_request_model.dart';
import '../../data/repositories/case_edit_repository.dart';

import '../../domain/entities/case_report_edit_request.dart';
import '../../domain/use_cases/compare_cases.dart';
import '../../domain/use_cases/create_instance_report.dart';
import '../../domain/use_cases/post_case_data.dart';

import '../cubit/case_editor/case_editor_cubit.dart';
import '../cubit/case_editor/case_editor_state.dart';
import '../cubit/select_editor/case_editor_select_cubit.dart';

import '../widgets/data_textArea.dart';
import '../widgets/data_textField.dart';
import '../widgets/end_case_status.dart';
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

  final ValueNotifier<String?> _roomValueController =
      ValueNotifier<String?>(null);
  final TextEditingController _roomNumberController = TextEditingController();
  final TextEditingController _symptomatologyController =
      TextEditingController();
  final TextEditingController _reasonConsultationController =
      TextEditingController();
  final TextEditingController _physicalStateController =
      TextEditingController();
  final TextEditingController _diagnosisController = TextEditingController();
  final ValueNotifier<String?> _entryAreaController =
      ValueNotifier<String?>(null);
  final ValueNotifier<String?> _referralController =
      ValueNotifier<String?>(null);
  final ValueNotifier<String?> _endStatusController =
      ValueNotifier<String?>(null);
  final TextEditingController _endDiagnosisController = TextEditingController();

  bool _isInit = true;

  @override
  void initState() {
    _isInit = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      dynamic args = ModalRoute.of(context)!.settings.arguments;
      initialPage = (args['id'] != null) ? args['id'] : 1;
      _pageController = PageController(initialPage: initialPage);
      if (args['casKey']['casSymptomatology'] != null) {
        _symptomatologyController.text = args['casKey']['casSymptomatology'];
      }
      if (args['casKey']['casPhysicalState'] != null) {
        _physicalStateController.text = args['casKey']['casPhysicalState'];
      }
      if (args['casKey']['casDiagnosis'] != null) {
        _diagnosisController.text = args['casKey']['casDiagnosis'];
      }
      if (args['casKey']['casActualRoom'] != null) {
        List<String> actualRoom = args['casKey']['casActualRoom'].split(' - ');
        _roomValueController.value = actualRoom[0][1];
        _roomNumberController.text =
            actualRoom[1].substring(1); // TODO CHANGE TO ALL CODE
      }
      if (args['casKey']['casEntryArea'] != null) {
        _entryAreaController.value = args['casKey']['casEntryArea'];
      }
      if (args['casKey']['casMethodOfEntry'] != null) {
        _referralController.value = args['casKey']['casMethodOfEntry'];
      }
      if (args['casKey']['casEndReason'] != null) {
        _endStatusController.value = endCaseTypeMeta[args['casKey']['casEndReason']];
      }
      if (args['casKey']['casEndDiagnosis'] != null) {
        _endDiagnosisController.text = args['casKey']['casEndDiagnosis'];
      }
    }
    super.didChangeDependencies();
    _isInit = false;
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
    _endStatusController.dispose();
    _endDiagnosisController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  CaseReportEditRequest _submitForm(int casKey, int patKey) {
    return CaseReportEditRequest(
        casId: casKey,
        patId: patKey,
        casSymptomatology: _symptomatologyController.text,
        casPhysicalState: _physicalStateController.text,
        casDiagnosis: _diagnosisController.text,
        casStudyImg: '',
        // TODO DELETE
        casMethodOfEntry: _referralController.value ?? '',
        casActualRoom:
            'A${_roomValueController.value ?? ''} - ${_roomValueController.value ?? ''}${_roomNumberController.text}',
        // TODO Change
        casEntryArea: _entryAreaController.value ?? '',
        casEndReason: _endStatusController.value ?? '',
        casEndDiagnosis: _endDiagnosisController.text);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyboardEnabled = MediaQuery.of(context).viewInsets.bottom;

    final CaseEditRequestRemoteDataSourceImpl caseEditRequestRemoteDataSource =
        CaseEditRequestRemoteDataSourceImpl();
    final CaseEditRepositoryImpl caseEditRepository =
        CaseEditRepositoryImpl(caseEditRequestRemoteDataSource);
    final PostCaseDateUseCase postCaseDateUseCase =
        PostCaseDateUseCase(caseEditRepository);
    final CreateInstanceCaseReportUseCase createInstanceCaseReportUseCase =
        CreateInstanceCaseReportUseCase();
    final CompareCasesUseCase compareCasesUseCase = CompareCasesUseCase();

    dynamic arguments = ModalRoute.of(context)!.settings.arguments;

    AuthUser authUser = arguments['AuthCredentials'];
    Map<String, dynamic> caseReport = arguments['casKey'];
    int patient = arguments['patKey']['patId'];
    int part = arguments['id'];

    print(arguments['casKey']['casEndReason']);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  CaseEditorCubit(postCaseDateUseCase, compareCasesUseCase)),
          BlocProvider(
              create: (_) =>
                  CaseEditorSelectCubit(createInstanceCaseReportUseCase)
                    ..onModifySelection(
                        arguments['title'].toString().toLowerCase(),
                        caseReport))
        ],
        child: BlocBuilder<CaseEditorSelectCubit, CaseEditorSelectState>(
            builder: (contextSelector, stateSelector) {
          return BlocConsumer<CaseEditorCubit, CaseEditorState>(
              listener: (contextCaseEditor, stateCaseEditor) {
            if (stateCaseEditor is CaseEditorLoading) {
              LoadingShowDialog.show(context, 'Actualizando Informacion');
            }
            if (stateCaseEditor is CaseEditorFail) {
              Navigator.of(contextCaseEditor).pop(true);
              Future.delayed(const Duration(milliseconds: 100), () {
                FloatingWarningSnackBar.show(
                    contextCaseEditor, stateCaseEditor.errorSMS);
              });
            }
            if (stateCaseEditor is CaseEditorWithoutUpdate) {
              Navigator.of(contextCaseEditor).pop(true);
              Future.delayed(const Duration(milliseconds: 100), () {
                FloatingWarningSnackBar.show(
                    contextCaseEditor, stateCaseEditor.errorSMS);
              });
            }
            if (stateCaseEditor is CaseEditorPosted) {
              Navigator.of(contextCaseEditor).pop(true);
              Future.delayed(const Duration(milliseconds: 100), () {
                FloatingSnackBar.show(
                    contextCaseEditor,
                    'Informe guardado con exito.',
                    Icons.check,
                    Colors.green); // TODO Safe color in styes folder
              });
              dynamic caseReportEditRequest =
                  CaseReportEditRequestModel.fromEntity(
                          stateCaseEditor.caseReportEditRequest)
                      .toJson();
              contextSelector.read<CaseEditorSelectCubit>().setOriginalCase(caseReportEditRequest);
            }
          }, builder: (contextCaseEditor, stateCaseEditor) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                    'Editar ${BlocProvider.of<CaseEditorSelectCubit>(contextSelector).getSelectionTitle()}'),
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
                                const SizedBox(
                                  height: 24,
                                ),
                                // TODO Make a global Widget
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: Text(
                                    "Descripcion de Enfermedad del paciente",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: CaseDataTextField(
                                    contextRow: 'Motivo de Consulta',
                                    controllerData:
                                        _reasonConsultationController,
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
                                    contextRow: 'Examen Fisico',
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
                                const SizedBox(
                                  height: 24,
                                ),
                                // TODO Make a global Widget
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: Text(
                                    "Descripcion de la localizacion del paciente",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
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
                                const SizedBox(
                                  height: 24,
                                ),
                                // TODO Make a global Widget
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: Text(
                                    "Descripcion del final del Caso",
                                    style:
                                    Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.075,
                                      vertical: size.height * 0.010,
                                    ),
                                    child: StatusField(
                                      controllerDataDropDown:
                                      _endStatusController,
                                    )),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.075,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: CaseDataTextArea(
                                      contextRow: 'Diagnostico Final',
                                      controllerData: _endDiagnosisController,
                                  maxLinesHeight: 6,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: keyboardEnabled == 0,
                    child: Positioned(
                        bottom: 50,
                        child: FetchUpdateButton(
                          size: size,
                          selected: 0,
                          endFindPatient: () => contextCaseEditor
                              .read<CaseEditorCubit>()
                              .postChanges(
                                  _submitForm(
                                      stateSelector.getSelectionCase()!.casId,
                                      patient),
                                  stateSelector.getSelectionCase()!,
                                  part,
                                  authUser.accessToken),
                        )),
                  ),
                ],
              ),
            );
          });
        }));
  }
}
