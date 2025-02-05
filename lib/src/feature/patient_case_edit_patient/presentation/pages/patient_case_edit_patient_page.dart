import 'package:d_report/my_flutter_app_icons.dart';
import 'package:d_report/src/feature/patient_case_edit_patient/domain/use_cases/post_patient_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/styles/static_colors.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/presentation/formatter/text_formatters.dart';
import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../../../../shared/presentation/widget/genre-user_field.dart';
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
import '../widgets/date_field.dart';
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
      print(args['patKey']);
      if (args['patKey']['patName'] != null) {
        // patFirstName
        _firstNameController.text = args['patKey']['patName'];
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
        _dniController.text = (args['patKey']['patDni']).toString();
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
        _guardianDniController.text =
            (args['patKey']['patGuardianDni']).toString();
      }
      if (args['patKey']['patBloodType'] != null) {
        _bloodTypeController.value = args['patKey']['patBloodType'];
      }
      if (args['casKey']['patWeight'] != null) {
        _weightDateController.text =
            Helper.writeWeightByInt(args['casKey']['patWeight']);
      }
      if (args['casKey']['patHeight'] != null) {
        _heightController.text =
            Helper.writeHeightByInt(args['casKey']['patHeight']);
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

  PatientEditRequest _submitForm(int patKey, int casKey) {
    return PatientEditRequest(
      casId: casKey,
      patId: patKey,
      patFirstName: Helper.capitalize(_firstNameController.text),
      patSecondName: Helper.capitalize(_secondNameController.text),
      patLastname: Helper.capitalize(_lastNameController.text),
      patSecondSurname: Helper.capitalize(_lastSurnameNameController.text),
      patDni: _dniController.text != '' ? int.parse(_dniController.text) : null,
      patBirthdayDate: _birthdayDateController.text,
      patGender: _genderTypeController.value ?? '',
      patBirthdayPlace: Helper.capitalize(_birthdayPlaceController.text, false),
      patBloodType: _bloodTypeController.value ?? '',
      patGuardianDni: int.parse(_guardianDniController.text),
      patWeight: _weightDateController.text != ''
          ? int.parse(Helper.writeWeightByDouble(
              double.parse(_weightDateController.text), true))
          : null,
      patHeight: _heightController.text != ''
          ? int.parse(Helper.writeHeightByDouble(
              double.parse(_heightController.text), true))
          : null,
    );
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
    patient['casId'] = arguments['casKey']['casId'];
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
                        arguments['title'].toString().toLowerCase(), patient))
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
                    ColorPalette.checkColor);
              });
              dynamic patientEditRequest = PatientEditRequestModel.fromEntity(
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
                                    controllerData: _firstNameController,
                                    textInputType: TextInputType.name,
                                    inputFormatters:
                                        TextFormatters.onlyLettersAndNumbers,
                                    iconData: Icons.person,
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
                                    textInputType: TextInputType.name,
                                    inputFormatters:
                                        TextFormatters.onlyLettersAndNumbers,
                                    iconData: Icons.person,
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
                                    textInputType: TextInputType.name,
                                    inputFormatters:
                                        TextFormatters.onlyLettersAndNumbers,
                                    iconData: Icons.person,
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
                                    textInputType: TextInputType.name,
                                    inputFormatters:
                                        TextFormatters.onlyLettersAndNumbers,
                                    iconData: Icons.person,
                                  ),
                                ),
                              ],
                            ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: size.height * 0.25,
                          ),
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
                                  child: DateTextField(
                                    contextRow: 'Fecha de Nacimiento',
                                    controllerData: _birthdayDateController,
                                  )),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.075,
                                  vertical: size.height * 0.010,
                                ),
                                child: CaseDataTextField(
                                  contextRow: 'Lugar de Nacimiento',
                                  controllerData: _birthdayPlaceController,
                                  textInputType: TextInputType.text,
                                  iconData: Icons.location_on,
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
                                            defaultValue: _genderTypeController.value,
                                        controllerData: _genderTypeController,
                                      )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: TypeBloodDropdownField(
                                        controllerData: _bloodTypeController,
                                      ))
                                    ],
                                  )),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.075,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: CaseDataTextField(
                                    contextRow: 'Cedula del Paciente',
                                    controllerData: _dniController,
                                    textInputType: TextInputType.number,
                                    inputFormatters:
                                        TextFormatters.dniFormatter,
                                    iconData: Icons.person,
                                  )),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.075,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: CaseDataTextField(
                                          contextRow: 'Peso (kilogramos)',
                                          controllerData: _weightDateController,
                                          textInputType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          inputFormatters: TextFormatters
                                              .onlyNumbersForMetrics,
                                          iconData: Icons.monitor_weight,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CaseDataTextField(
                                          contextRow: 'Altura (Metros)',
                                          controllerData: _heightController,
                                          textInputType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          inputFormatters: TextFormatters
                                              .onlyNumbersForMetrics,
                                          iconData: Icons.height, // Icon(Icons.text_snippet)
                                        ),
                                      )
                                    ],
                                  )),
                            ],
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
                                      patient['casId']),
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
