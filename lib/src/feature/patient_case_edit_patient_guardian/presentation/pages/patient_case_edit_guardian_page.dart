import 'package:d_report/src/feature/patient_case_edit_patient_guardian/domain/entities/patient_guardian_edit_request.dart';
import 'package:d_report/src/feature/patient_case_edit_patient_guardian/domain/use_cases/compare_patient_guardians.dart';
import 'package:d_report/src/feature/patient_case_edit_patient_guardian/domain/use_cases/create_instance_patient_guardian.dart';
import 'package:d_report/src/feature/patient_case_edit_patient_guardian/presentation/cubit/select_editor/patient_guardian_editor_select_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../../../../shared/presentation/widget/loading_show_dialog.dart';
import '../../data/datasource/remote/patient_guardian_edit_request_remote_data_source.dart';
import '../../data/models/patient_guardian_edit_request_model.dart';
import '../../data/repositories/patient_guardian_edit_repository.dart';
import '../../domain/entities/patient_guardian.dart';
import '../../domain/use_cases/post_patient_guardian_data.dart';
import '../cubit/patient_guardian_editor/patient_guardian_editor_cubit.dart';
import '../cubit/patient_guardian_editor/patient_guardian_editor_state.dart';
import '../cubit/select_editor/patient_guardian_editor_select_state.dart';
import '../widgets/data_textField.dart';
import '../widgets/data_textArea.dart';
import '../widgets/next_state_button.dart';

class EditCasePatientGuardianPage extends StatefulWidget {
  const EditCasePatientGuardianPage({super.key});

  @override
  MyEditCasePatientState createState() => MyEditCasePatientState();
}

class MyEditCasePatientState extends State<EditCasePatientGuardianPage> {
  final TextEditingController _guardianDniController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _tlfController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isInit = true;

  @override
  void initState() {
    _isInit = true;
    super.initState();
  }

  /*@override
  void didChangeDependencies() {
    if (_isInit) {
      dynamic args = ModalRoute.of(context)!.settings.arguments;
      if (args['patKey']['patGuardianDni']['patGuardianDni'] != null) {
        _guardianDniDateController.text =
            args['patKey']['patGuardianDni']['patGuardianDni'];
      }
      if (args['patKey']['patGuardianDni']['patGuEmail'] != null) {
        _emailController.text = args['patKey']['patGuardianDni']['patGuEmail'];
      }
      if (args['patKey']['patGuardianDni']['patGeTlf'] != null) {
        _tlfController.text = args['patKey']['patGuardianDni']['patGeTlf'];
      }
      if (args['patKey']['patGuardianDni']['patGuAddress'] != null) {
        _addressController.text =
            args['patKey']['patGuardianDni']['patGuAddress'];
      }
    }
    super.didChangeDependencies();
    _isInit = false;
  }*/

  @override
  void dispose() {
    _guardianDniController.dispose();
    _emailController.dispose();
    _tlfController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  PatientGuardianEditRequest _submitForm(int patGuId) {
    return PatientGuardianEditRequest(
      patGuId: patGuId,
      patGuDni: int.parse(_guardianDniController.text),
      patGuAddress: _addressController.text,
      patGuTlf: _tlfController.text,
      patGuEmail: _emailController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyboardEnabled = MediaQuery.of(context).viewInsets.bottom;

    final PatientGuardianEditRequestRemoteDataSourceImpl
        patientGuardianEditRequestRemoteDataSource =
        PatientGuardianEditRequestRemoteDataSourceImpl();
    final PatientGuardianEditRepositoryImpl patientGuardianEditRepository =
        PatientGuardianEditRepositoryImpl(
            patientGuardianEditRequestRemoteDataSource);
    final PostPatientGuardianDateUseCase postPatientGuardianDateUseCase =
        PostPatientGuardianDateUseCase(patientGuardianEditRepository);
    final CreateInstancePatientGuardianUseCase
        createInstancePatientGuardianUseCase =
        CreateInstancePatientGuardianUseCase();
    final ComparePatientGuardiansUseCase comparePatientGuardiansUseCase =
        ComparePatientGuardiansUseCase();

    dynamic arguments = ModalRoute.of(context)!.settings.arguments;

    AuthUser authUser = arguments['AuthCredentials'];
    //Map<String, dynamic> patient = arguments['patKey'];

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => PatientGuardianEditorCubit(
                  postPatientGuardianDateUseCase,
                  comparePatientGuardiansUseCase)),
          BlocProvider(
              create: (_) => PatientGuardianEditorSelectCubit(
                  createInstancePatientGuardianUseCase)
                ..onModifySelection(
                    arguments['title'].toString().toLowerCase(),
                    PatientGuardian(
                        patGuId: 1,
                        patGuDni: 12345,
                        patGuAddress: 'Sabana Grande',
                        patGuTlf: '+58 424 323-8366',
                        patGuEmail: 'ja.teix@gmail.com'))),
        ], // TODO HARDCODE
        child: BlocBuilder<PatientGuardianEditorSelectCubit,
            PatientGuardianEditorSelectState>(
          builder: (contextSelector, stateSelector) {
            return BlocConsumer<PatientGuardianEditorCubit,
                PatientGuardianEditorState>(
              listener: (contextGuardianEditor, stateGuardianEditor) {
                if (stateGuardianEditor is PatientGuardianEditorLoading) {
                  LoadingShowDialog.show(context, 'Actualizando Informacion');
                }
                if (stateGuardianEditor is PatientGuardianEditorFail) {
                  Navigator.of(contextGuardianEditor).pop(true);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    FloatingWarningSnackBar.show(
                        contextGuardianEditor, stateGuardianEditor.errorSMS);
                  });
                }
                if (stateGuardianEditor is PatientGuardianEditorWithoutUpdate) {
                  Navigator.of(contextGuardianEditor).pop(true);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    FloatingWarningSnackBar.show(
                        contextGuardianEditor, stateGuardianEditor.errorSMS);
                  });
                }
                if (stateGuardianEditor is PatientGuardianEditorPosted) {
                  Navigator.of(contextGuardianEditor).pop(true);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    FloatingSnackBar.show(
                        contextGuardianEditor,
                        'Informe guardado con exito.',
                        Icons.check,
                        Colors.green); // TODO Safe color in styes folder
                  });
                  dynamic patientGuardianEditRequest =
                      PatientGuardianEditRequestModel.fromEntity(
                              stateGuardianEditor.patientGuardianEditRequest)
                          .toJson();
                  contextSelector
                      .read<PatientGuardianEditorSelectCubit>()
                      .setOriginalPatientGuardian(patientGuardianEditRequest);
                }
              },
              builder: (contextGuardianEditor, stateGuardianEditor) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                        'Editar ${BlocProvider.of<PatientGuardianEditorSelectCubit>(contextSelector).getSelectionTitle()}'),
                  ),
                  body: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      PageView(
                        children: [
                          SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: size.height * 0.25,
                              ),
                              child: IntrinsicHeight(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        "Datos del Representante",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: size.height * 0.010,
                                      ),
                                      child: CaseDataTextField(
                                        contextRow: 'Cedula de Identidad',
                                        controllerData: _guardianDniController,
                                        textInputType: TextInputType.number,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: size.height * 0.010,
                                      ),
                                      child: CaseDataTextArea(
                                        contextRow: 'Direccion Corta',
                                        controllerData: _addressController,
                                        maxLinesHeight: 3,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: size.height * 0.010,
                                      ),
                                      child: CaseDataTextField(
                                        contextRow: 'Telefono',
                                        controllerData: _tlfController,
                                        textInputType: TextInputType.phone,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: size.height * 0.010,
                                      ),
                                      child: CaseDataTextField(
                                        contextRow: 'Correo',
                                        controllerData: _emailController,
                                        textInputType:
                                            TextInputType.emailAddress,
                                      ),
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
                              endFindPatient: () => contextGuardianEditor
                                  .read<PatientGuardianEditorCubit>()
                                  .postChanges(
                                      _submitForm(
                                        stateSelector
                                            .getSelectionGuPat()!
                                            .patGuId,
                                      ),
                                      stateSelector.getSelectionGuPat()!,
                                      authUser.accessToken),
                            )),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
