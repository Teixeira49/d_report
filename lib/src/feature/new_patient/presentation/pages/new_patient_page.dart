import 'package:d_report/src/feature/new_patient/presentation/cubit/new_patient/new_patient_case_state.dart';

import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/genre-user_field.dart';
import '../../data/datasource/remote/new_patient_case_remote_datasource.dart';
import '../../data/repository/new_patient_case_repository_impl.dart';
import '../cubit/new_patient/new_patient_case_cubit.dart';
import '../widgets/blood_type_field.dart';
import '../widgets/data_textField_numeric.dart';
import '../widgets/data_textField_text.dart';
import '../widgets/date_field.dart';
import '../widgets/next_state_button.dart';

class NewPatientPage extends StatefulWidget {
  const NewPatientPage({super.key});

  @override
  MyNewPatientPageState createState() => MyNewPatientPageState();
}

class MyNewPatientPageState extends State<NewPatientPage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _patNameController = TextEditingController();
  final TextEditingController _patLastNameController = TextEditingController();
  final TextEditingController _patDniController = TextEditingController();
  final TextEditingController _patBirthDateController = TextEditingController();
  final ValueNotifier<String?> _patGenderController =
      ValueNotifier<String?>(null);
  final TextEditingController _patGuDniController = TextEditingController();
  final ValueNotifier<String?> _patBloodTypeController =
      ValueNotifier<String?>(null);

  @override
  void dispose() {
    _patNameController.dispose();
    _patLastNameController.dispose();
    _patBirthDateController.dispose();
    _patGenderController.dispose();
    _patGuDniController.dispose();
    _patBloodTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final newPatientCaseDataSource = NewPatientCaseRemoteDataSourceImpl();
    final repository = NewPatientCaseRepositoryImpl(
        newPatientCaseRemoteDataSource: newPatientCaseDataSource);

    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    return BlocProvider(
      create: (_) => CheckPatientCubit(repository),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            registerData + space + patient,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocConsumer<CheckPatientCubit, CheckPatientState>(
          listener: (context, state) {
            if (state is CheckPatientLoaded) {
              Future.delayed(const Duration(seconds: 1), () {
                if (state.sms == '') {
                  // TODO research how change this

                  Map<String, dynamic> x = {
                    'patName': _patNameController.text,
                    'patLastName': _patLastNameController.text,
                    'patDni': _patDniController.text != "" ? int.parse(_patDniController.text) : null,
                    'patGender': _patGenderController.value,
                    'patBirthdayDate': _patBirthDateController.text,
                    'patBirthdayPlace': '',
                    'patGuardianDni': int.parse(_patGuDniController.text),
                    'patBloodType': _patBloodTypeController.value,
                  };

                  Navigator.of(context)
                      .pushNamed('/main/new-case/add-case', arguments: {
                    "userData": user,
                    "AuthCredentials": authUser,
                    "patient": x,
                  });
                } else { // Patient already exist
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Error: ${state.sms}',
                      textAlign: TextAlign.center, // TODO Make Global
                    ),
                    backgroundColor:
                    Theme.of(context).appBarTheme.backgroundColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                  ));
                }
              });
            } else if (state is CheckPatientFail) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Error: ${state.errorSMS}',
                  textAlign: TextAlign.center, // TODO Make Global
                ),
                backgroundColor:
                Theme.of(context).appBarTheme.backgroundColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
              ));
            }
          },
          builder: (context, state) {
            return Center(
                child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height * 0.25,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.010,
                          vertical: size.width * 0.020,
                        ),
                        child: Text(
                          "Porfavor complete la información del paciente",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: PatientDataTextField(
                              contextRow: 'Nombre',
                              controllerData: _patNameController,
                              iconData: Icons.person,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: PatientDataTextField(
                              contextRow: 'Apelllido',
                              controllerData: _patLastNameController,
                              iconData: Icons.person,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: PatientDataTextFieldNumeric(
                              contextRow: 'CI Paciente',
                              controllerData: _patDniController,
                              iconData: Icons.perm_contact_cal,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: DateTextField(
                              controllerData: _patBirthDateController,
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
                                  controllerData: _patGenderController,
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: TypeBloodDropdownField(
                                        controllerData:
                                            _patBloodTypeController))
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: PatientDataTextFieldNumeric(
                              contextRow: 'CI Representante',
                              controllerData: _patGuDniController,
                              iconData: Icons.contact_emergency,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Flexible(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.010),
                            child: (state is CheckPatientLoading) ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            ): NextStateButton(
                              patName: _patNameController.text,
                              patLastName: _patLastNameController.text,
                              patGuDni: _patGuDniController.text,
                              patBirthDate: _patBirthDateController.text,
                              patGender: _patGenderController.value,
                              patBloodType: _patBloodTypeController.value,
                              accessToken: authUser.accessToken,
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}
