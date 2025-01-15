import 'package:d_report/src/feature/patient_case_edit_patient_guardian/domain/use_cases/create_instance_patient_guardian.dart';
import 'package:d_report/src/feature/patient_case_edit_patient_guardian/presentation/cubit/select_editor/patient_guardian_editor_select_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasource/remote/patient_guardian_edit_request_remote_data_source.dart';
import '../../data/repositories/patient_guardian_edit_repository.dart';
import '../../domain/use_cases/post_patient_guardian_data.dart';

class EditCasePatientGuardianPage extends StatefulWidget {
  const EditCasePatientGuardianPage({super.key});

  @override
  MyEditCasePatientState createState() => MyEditCasePatientState();
}

class MyEditCasePatientState extends State<EditCasePatientGuardianPage> {
  final TextEditingController _guardianDniDateController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _tlfController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

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
  }

  @override
  void dispose() {
    _guardianDniDateController.dispose();
    _emailController.dispose();
    _tlfController.dispose();
    _addressController.dispose();
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
    final CreateInstancePatientGuardianUseCase
        createInstancePatientGuardianUseCase =
        CreateInstancePatientGuardianUseCase();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                PatientGuardianEditorSelectCubit(createInstancePatientGuardianUseCase))
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ejemplo'),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height * 0.25,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height * 0.25,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.075,
                            vertical: size.height * 0.020,
                          ),
                          child: Text("editar"),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //Text('No se que poner aqui')
          ],
        ),
      ),
    );
  }
}
