import 'package:d_report/src/feature/patient_case_edit_patient/domain/use_cases/post_patient_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../../../../shared/presentation/widget/loading_show_dialog.dart';
import '../../data/datasource/remote/patient_edit_request_remote_data_source.dart';
import '../../data/models/patient_report_edit_request_model.dart';
import '../../data/repositories/patient_edit_repository.dart';
import '../../domain/entities/patient_edit_request.dart';
import '../../domain/use_cases/compare_patients.dart';
import '../../domain/use_cases/create_instance_patient.dart';
import '../cubit/patient_editor/patient_editor_cubit.dart';
import '../cubit/patient_editor/patient_editor_state.dart';
import '../cubit/select_editor/patient_editor_select_cubit.dart';
import '../cubit/select_editor/patient_editor_select_state.dart';
import '../widgets/blood_type_field.dart';
import '../widgets/data_textField.dart';
import '../widgets/genre-user_field.dart';
import '../widgets/next_state_button.dart';

class EditCasePatientPage extends StatefulWidget {
  const EditCasePatientPage({super.key});

  @override
  MyEditCasePatientState createState() => MyEditCasePatientState();
}

class MyEditCasePatientState extends State<EditCasePatientPage> {
  late final int initialPage;

  late final PageController _pageController;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _lastSurnameNameController =
      TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final ValueNotifier<String?> _genderTypeController =
      ValueNotifier<String?>(null);
  final TextEditingController _birthdayDateController = TextEditingController();
  final TextEditingController _birthdayPlaceController =
      TextEditingController();
  final TextEditingController _guardianDniController = TextEditingController();
  final ValueNotifier<String?> _bloodTypeController =
      ValueNotifier<String?>(null);
  final TextEditingController _weightDateController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

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
      if (args['patKey']['patFirstName'] != null) {
        _firstNameController.text = args['patKey']['patFirstName'];
      }
      if (args['patKey']['patSecondName'] != null) {
        _secondNameController.text = args['patKey']['patSecondName'];
      }
      if (args['patKey']['patLastname'] != null) {
        _lastNameController.text = args['patKey']['patLastname'];
      }
      if (args['patKey']['patSecondSurname'] != null) {
        _lastSurnameNameController.text = args['patKey']['patSecondSurname'];
      }
      if (args['patKey']['patDni'] != null) {
        _dniController.text = args['patKey']['patDni'];
      }
      if (args['patKey']['patGender'] != null) {
        _genderTypeController.value = args['patKey']['patGender'];
      }
      if (args['patKey']['patBirthdayDate'] != null) {
        _birthdayDateController.text = args['patKey']['patBirthdayDate'];
      }
      if (args['patKey']['patBirthdayPlace'] != null) {
        _birthdayPlaceController.text = args['patKey']['patBirthdayPlace'];
      }
      if (args['patKey']['patGuardianDni'] != null) {
        _guardianDniController.text = args['patKey']['patGuardianDni'];
      }
      if (args['patKey']['patBloodType'] != null) {
        _bloodTypeController.value = args['patKey']['patBloodType'];
      }
      if (args['patKey']['patWeight'] != null) {
        _weightDateController.text = args['patKey']['patWeight'];
      }
      if (args['patKey']['patHeight'] != null) {
        _heightController.text = args['patKey']['patHeight'];
      }
    }
    super.didChangeDependencies();
    _isInit = false;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _secondNameController.dispose();
    _lastNameController.dispose();
    _lastSurnameNameController.dispose();
    _dniController.dispose();
    _genderTypeController.dispose();
    _birthdayDateController.dispose();
    _birthdayPlaceController.dispose();
    _guardianDniController.dispose();
    _bloodTypeController.dispose();
    _weightDateController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  PatientEditRequest _submitForm(int patKey) {
    return PatientEditRequest(
        patId: patKey,
        patFirstName: '',
        patSecondName: '',
        patLastname: '',
        patSecondSurname: '',
        patDni: null,
        patBirthdayDate: '',
        patGender: '',
        patBirthdayPlace: '',
        patBloodType: '',
        patGuardianDni: 1,
        patWeight: null,
        patHeight: null);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyboardEnabled = MediaQuery.of(context).viewInsets.bottom;

    final PatientEditRequestRemoteDataSourceImpl
        patientEditRequestRemoteDataSource =
        PatientEditRequestRemoteDataSourceImpl();
    final PatientEditRepositoryImpl patientEditRepository =
        PatientEditRepositoryImpl(patientEditRequestRemoteDataSource);
    final PostPatientDataUseCase postPatientDataUseCase =
        PostPatientDataUseCase(patientEditRepository);
    final CreateInstancePatientUseCase createInstancePatientUseCase =
        CreateInstancePatientUseCase();
    final ComparePatientsUseCase comparePatientsUseCase =
        ComparePatientsUseCase();

    dynamic arguments = ModalRoute.of(context)!.settings.arguments;

    AuthUser authUser = arguments['AuthCredentials'];
    Map<String, dynamic> patient = arguments['patKey'];
    patient['patWeight'] = arguments['casKey']['patWeight'];
    patient['patHeight'] = arguments['casKey']['patHeight'];
    int part = arguments['id'];

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => PatientEditorCubit(
                  postPatientDataUseCase, comparePatientsUseCase)),
          BlocProvider(
              create: (_) =>
                  PatientEditorSelectCubit(createInstancePatientUseCase)
                    ..onModifySelection(
                        arguments['title'].toString().toLowerCase(),
                        patient))
        ],
        child: BlocBuilder<PatientEditorSelectCubit, PatientEditorSelectState>(
            builder: (contextSelector, stateSelector) {
          return BlocConsumer<PatientEditorCubit, PatientEditorState>(
              listener: (contextPatientEditor, statePatientEditor) {
            if (statePatientEditor is PatientEditorLoading) {
              LoadingShowDialog.show(context, 'Actualizando Informacion');
            }
            if (statePatientEditor is PatientEditorFail) {
              Navigator.of(contextPatientEditor).pop(true);
              Future.delayed(const Duration(milliseconds: 100), () {
                FloatingWarningSnackBar.show(
                    contextPatientEditor, statePatientEditor.errorSMS);
              });
            }
            if (statePatientEditor is PatientEditorWithoutUpdate) {
              Navigator.of(contextPatientEditor).pop(true);
              Future.delayed(const Duration(milliseconds: 100), () {
                FloatingWarningSnackBar.show(
                    contextPatientEditor, statePatientEditor.errorSMS);
              });
            }
            if (statePatientEditor is PatientEditorPosted) {
              Navigator.of(contextPatientEditor).pop(true);
              Future.delayed(const Duration(milliseconds: 100), () {
                FloatingSnackBar.show(
                    contextPatientEditor,
                    'Informe guardado con exito.',
                    Icons.check,
                    Colors.green); // TODO Safe color in styles folder
              });
              dynamic patientEditRequest =
                  PatientEditRequestModel.fromEntity(
                          statePatientEditor.patientEditRequest)
                      .toJson();
              contextSelector
                  .read<PatientEditorSelectCubit>()
                  .setOriginalPatient(patientEditRequest);
            }
          }, builder: (contextPatientEditor, statePatientEditor) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                    'Editar ${BlocProvider.of<PatientEditorSelectCubit>(contextSelector).getSelectionTitle()}'),
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
                                    "Datos Primordiales del Paciente",
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
                                    contextRow: 'Primer Nombre',
                                    controllerData:
                                        _firstNameController,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: CaseDataTextField(
                                    contextRow: 'Segundo Nombre',
                                    controllerData: _secondNameController,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: CaseDataTextField(
                                    contextRow: 'Primer Apellido',
                                    controllerData: _lastNameController,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: CaseDataTextField(
                                    contextRow: 'Segundo Apellido',
                                    controllerData: _lastSurnameNameController,
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
                                    "Datos Caracteristicos del Paciente",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.075,
                                      vertical: size.height * 0.010,
                                    ),
                                    child: Row(
                                      children: [
                                        CaseDataTextField(
                                          contextRow: 'Fecha de Nacimiento',
                                          controllerData: _birthdayDateController,
                                        )
                                      ],
                                    )),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.075,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: CaseDataTextField(
                                    contextRow: 'Lugar de Nacimiento',
                                    controllerData: _birthdayPlaceController,
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.075,
                                      vertical: size.height * 0.010,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: TypeGenreDropdownField(
                                              controllerData: _genderTypeController,
                                            )
                                        ),
                                        Expanded(
                                            child: TypeBloodDropdownField(
                                              controllerData: _bloodTypeController,
                                            )
                                        )
                                      ],
                                    )),
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
                          endFindPatient: () => contextPatientEditor
                              .read<PatientEditorCubit>()
                              .postChanges(
                                  _submitForm(
                                    stateSelector.getSelectionPat()!.patId,
                                  ),
                                  stateSelector.getSelectionPat()!,
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
