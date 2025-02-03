import 'package:d_report/src/feature/new_case/data/datasource/remote/new_case_remote_datasource.dart';
import 'package:d_report/src/feature/new_case/data/repository/new_case_repository_impl.dart';
import 'package:d_report/src/feature/new_case/presentation/cubit/new_patient/new_patient_case_cubit.dart';
import 'package:d_report/src/feature/new_case/presentation/cubit/new_patient/new_patient_case_state.dart';
import 'package:d_report/src/shared/presentation/widget/loading_show_dialog.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../widgets/data_textArea.dart';
import '../widgets/data_textField.dart';
import '../widgets/entry_area_field.dart';
import '../widgets/finish_button.dart';
import '../widgets/floor_field.dart';
import '../widgets/is_referral_field.dart';

class NewCasePage extends StatefulWidget {
  const NewCasePage({super.key});

  @override
  MyNewCasePageState createState() => MyNewCasePageState();
}

class MyNewCasePageState extends State<NewCasePage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _casAdmissionReasonController =
      TextEditingController();
  final TextEditingController _casSymptomatologyController =
      TextEditingController();
  final TextEditingController _casPhysicalStateController =
      TextEditingController();
  final TextEditingController _casDiagnosisController = TextEditingController();

  //final TextEditingController _casStudyImgDateController = TextEditingController();
  final bool _casMethodOfEntryController = false;
  final TextEditingController _casActualRoomController =
      TextEditingController();
  final ValueNotifier<String?> _casFloorLevelController = ValueNotifier(null);
  final ValueNotifier<String?> _casEntryAreaController = ValueNotifier(null);

  @override
  void dispose() {
    _casSymptomatologyController.dispose();
    _casPhysicalStateController.dispose();
    _casDiagnosisController.dispose();
    _casActualRoomController.dispose();
    _casFloorLevelController.dispose();
    _casEntryAreaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyboardEnabled = MediaQuery.of(context).viewInsets.bottom;

    final newPatientCaseDataSource = NewPatientCaseRemoteDataSourceImpl();
    final repository = NewPatientCaseRepositoryImpl(
        newPatientCaseRemoteDataSource: newPatientCaseDataSource);

    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];
    dynamic patData = argument['patient'];
    bool casStatus = argument['createStatus'];

    return BlocProvider(
      create: (_) => NewCasePatientCubit(repository),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            caseDetails,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          automaticallyImplyLeading: true,
        ),
        body: BlocConsumer<NewCasePatientCubit, NewCasePatientState>(
          listener: (context, state) {
            if (state is NewCasePatientLoading) {
              LoadingShowDialog.show(context, 'Creando Caso');
            } else if (state is NewCasePatientLoaded) {
              Future.delayed(const Duration(seconds: 1), () {
                //Navigator.of(context) // TODO Ineficiente, acumula mas widgets en pantalla
                //    .pushNamed('/main/patients/', arguments: {
                //  "userData": user,
                //  "AuthCredentials": authUser,
                //  "patient": '',
                //});
                FloatingSnackBar.show(
                    context,
                    'Paciente Registrado exitosamente en ${state.caseReport.casEntryArea}',
                    Icons.check,
                    Colors.green);
                Navigator.of(context).pop(); // TODO Change for PopUntil
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
            } else if (state is NewCasePatientFail) {
              Navigator.of(context).pop();
              FloatingWarningSnackBar.show(context, state.errorSMS);
            }
          },
          builder: (context, state) {
            return Stack(alignment: Alignment.topCenter, children: [
              Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: size.height * 0.25,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Flexible(
                              child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.010,
                              vertical: size.width * 0.020,
                            ),
                            child: Text(
                              "Información sobre el caso del paciente",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )),
                          const SizedBox(height: 4,),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 10),
                                Text('Paciente Referido:', style: Theme.of(context).inputDecorationTheme.labelStyle,),
                                const Spacer(),
                                ConfigSwitch(
                                  configVar: _casMethodOfEntryController,
                                  onChanged: (newValue) {
                                    !_casMethodOfEntryController;
                                  },
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                          Divider(indent: size.width * 0.075, endIndent: size.width * 0.075, color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5)),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: CaseDataTextField(
                              contextRow: 'Motivo de Consulta',
                              controllerData: _casAdmissionReasonController,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: CaseDataTextArea(
                              contextRow: 'Enfermedad Actual',
                              controllerData: _casSymptomatologyController,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: CaseDataTextArea(
                              contextRow: 'Examen Fisico',
                              controllerData: _casPhysicalStateController,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: CaseDataTextField(
                              contextRow: 'Diagnostico Inicial',
                              controllerData: _casDiagnosisController,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: Text(
                              "Area De internacion del paciente",
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
                                    _casFloorLevelController,
                                controllerDataTextField:
                                    _casActualRoomController,
                              )),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: EntryAreaDropdownField(
                                controllerData: _casEntryAreaController),
                          ),
                          const SizedBox(
                            height: 94,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: keyboardEnabled == 0,
                  child: Positioned(
                    bottom: 30,
                    child: FinishRegisterCaseButton(
                            casMethodOfEntry: _casMethodOfEntryController,
                            patData: patData,
                            casAdmissionReason:
                                _casAdmissionReasonController.text,
                            casSymptomatology:
                                _casSymptomatologyController.text,
                            casPhysicalState: _casPhysicalStateController.text,
                            casDiagnosis: _casDiagnosisController.text,
                            casActualRoom: _casActualRoomController.text,
                            casFloorLevel:
                                _casFloorLevelController.value.toString(),
                            casEntryArea:
                                _casEntryAreaController.value.toString(),
                            docId: user.userProfileId,
                            accessToken: authUser.accessToken,
                            size: size, casStatus: casStatus,
                          ),
                  )),
            ]);
          },
        ),
      ),
    );
  }
}
