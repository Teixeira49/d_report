import 'package:d_report/src/feature/end_case/data/datasource/remote/end_case_remote_data_source.dart';
import 'package:d_report/src/feature/end_case/data/repositories/end_case_repository.dart';
import 'package:d_report/src/feature/end_case/presentation/cubit/end_case_send/end_case_send_state.dart';
import 'package:d_report/src/shared/presentation/widget/circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/fields_constants.dart';
import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../../domain/entities/end_reasons.dart';
import '../cubit/end_case_send/end_case_send_cubit.dart';
import '../widgets/data_textArea.dart';
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

    dynamic arguments = ModalRoute.of(context)?.settings.arguments;
    AuthUser authUser = arguments["authCredentials"];
    String patName = arguments["patName"];
    int patId = arguments["patId"];
    int casId = arguments["casKey"];

    return BlocProvider(
        create: (_) => SendEndCaseCubit(endCaseRepositoryImpl: repository),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Fin del caso'),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        children: [
                          const Text(
                            'Paciente:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(patName),
                          const SizedBox(
                            width: 15,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Estatus final:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Flexible(
                              child: StatusField(
                            controllerDataDropDown: _endStatusController,
                          ))
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text(
                        'Diagnostico',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CaseDataTextArea(
                      contextRow: 'Diagnostico Final',
                      controllerData: _endDiagnosisData,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        child: const Text(
                          "Utilice este espacio para narrar el final del caso, y describir el padecimiento que realmente tenia el paciente",
                          textAlign: TextAlign.justify,
                        )),
                    const Spacer(),
                    Expanded(
                        child: BlocConsumer<SendEndCaseCubit, SendEndCaseState>(
                      listener: (context, state) {
                        if (state is SendEndCaseLoaded) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        } else if (state is SendEndCaseTimeout) {
                          FloatingWarningSnackBar.show(context, state.sms);
                        } else if (state is SendEndCaseFail) {
                          FloatingWarningSnackBar.show(context, state.errorSMS);
                        }
                      },
                      builder: (context, state) {
                        if (state is SendEndCaseInitial) {
                          return TextButton(
                              onPressed: () {
                                if (_endDiagnosisData.text.isNotEmpty &&
                                    _endStatusController.value!.isNotEmpty) {
                                  String x = EndReasons.values[endCaseType.indexOf(_endStatusController.value.toString())].name;
                                  context.read<SendEndCaseCubit>().sendEndCaseData(casId, patId, x, _endDiagnosisData.text, authUser.accessToken);
                                } else {
                                  _formKey.currentState?.validate();
                                }
                              },
                              child: const Text('Finalizar'));
                        } else if (state is SendEndCaseLoading) {
                          return const Center(
                            child: CustomCircularProgressBar(),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ))
                  ],
                ),
              )),
            ),
          ),
        ));
  }
}
