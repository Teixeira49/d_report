import 'package:d_report/src/feature/end_case/data/datasource/remote/end_case_remote_data_source.dart';
import 'package:d_report/src/feature/end_case/data/repositories/end_case_repository.dart';
import 'package:d_report/src/feature/end_case/presentation/cubit/end_case_send/end_case_send_state.dart';
import 'package:d_report/src/shared/presentation/widget/bullet.dart';
import 'package:d_report/src/shared/presentation/widget/loading_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/helpers.dart';
import '../../../../core/utils/constants/fields_constants.dart';
import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../../domain/entities/end_reasons.dart';
import '../cubit/end_case_send/end_case_send_cubit.dart';
import '../widgets/data_textArea.dart';
import '../widgets/end_case_button.dart';
import '../widgets/end_case_status.dart';

class EndCasePage extends StatefulWidget {
  const EndCasePage({super.key});

  @override
  MyEndCasePage createState() => MyEndCasePage();
}

class MyEndCasePage extends State<EndCasePage> {
  final TextEditingController _endDiagnosisData = TextEditingController();
  final ValueNotifier<String?> _endStatusController = ValueNotifier(null);
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _endDiagnosisData.dispose();
    _endStatusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = EndCaseRemoteDataSourceImpl();
    final repository = EndCaseRepositoryImpl(remoteDataSource);

    final size = MediaQuery.of(context).size;
    final keyboardEnabled = MediaQuery.of(context).viewInsets.bottom;

    dynamic arguments = ModalRoute.of(context)?.settings.arguments;
    AuthUser authUser = arguments["authCredentials"];
    String patName = arguments["patName"];
    int patId = arguments["patId"];
    int casId = arguments["casKey"];
    String casStartDate = arguments['casStartDate'];

    return BlocProvider(
        create: (_) => SendEndCaseCubit(endCaseRepositoryImpl: repository),
        child: BlocConsumer<SendEndCaseCubit, SendEndCaseState>(
            listener: (context, state) {
          if (state is LoadingShowDialog) {
            LoadingShowDialog.show(context, 'Descargando Archivo');
          } else if (state is SendEndCaseLoaded) {
            Navigator.of(context, rootNavigator: true).pop();
            Future.delayed(const Duration(milliseconds: 100), () {
              FloatingSnackBar.show(
                  context,
                  'Caso Finalizado con Exito.',
                  Icons.check,
                  Colors.green); // TODO Safe color in styles folder
              Navigator.pop(context);
            });
          } else if (state is SendEndCaseTimeout) {
            FloatingWarningSnackBar.show(context, state.sms);
          } else if (state is SendEndCaseFail) {
            FloatingWarningSnackBar.show(context, state.errorSMS);
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cierre del Caso'),
              automaticallyImplyLeading: true,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height * 0.25,
                ),
                child: IntrinsicHeight(
                    child: Form(
                  key: _formKey,
                  child: Container(
                      margin: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Paciente',
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.start,
                          ),
                          Divider(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withOpacity(0.5),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.person),
                              const SizedBox(
                                width: 12,
                              ),
                              const Text(
                                'Paciente',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Text(patName),
                              const SizedBox(
                                width: 18,
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.assignment_late),
                              const SizedBox(
                                width: 12,
                              ),
                              const Text(
                                'Estatus final',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              SizedBox(
                                  width: size.width / 3.3,
                                  //color: Colors.green,
                                  child: StatusField(
                                    controllerDataDropDown:
                                        _endStatusController,
                                  ))
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.access_time_filled),
                              const SizedBox(
                                width: 12,
                              ),
                              const Text(
                                "Tiempo en Atencion",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Text("${Helper.countCaseDaysByString(casStartDate)} Dias"),
                              const SizedBox(width: 22)
                            ],
                          ),
                          const Divider(),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Text(
                              'Diagnostico',
                              style: Theme.of(context).textTheme.headlineSmall,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Divider(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withOpacity(0.5),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          CaseDataTextArea(
                            contextRow: 'Diagnostico Final',
                            controllerData: _endDiagnosisData,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 12),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BulletDecorator(
                                      sizeBullet: 5,
                                      marginHorizontal: 5,
                                      marginVertical: 7.5),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Utilice este espacio para describir el cierre del caso, y explicando clinicamente el diagnostico real del paciente.",
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              )),
                        ],
                      )),
                )),
              ),
            ),
            bottomSheet: Visibility(
              visible: keyboardEnabled == 0,
              child: EndCaseButton(size: size, endFunction: () {
                if (_endDiagnosisData.text.isNotEmpty &&
                    _endStatusController
                        .value!.isNotEmpty) {
                  String x = EndReasons
                      .values[endCaseType.indexOf(
                      _endStatusController.value
                          .toString())]
                      .name;
                  context
                      .read<SendEndCaseCubit>()
                      .sendEndCaseData(
                      casId,
                      patId,
                      x,
                      _endDiagnosisData.text,
                      authUser.accessToken);
                } else {
                  _formKey.currentState?.validate();
                }
              },),
            ),
          );
        }));
  }
}
