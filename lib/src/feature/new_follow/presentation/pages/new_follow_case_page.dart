import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../data/datasource/remote/new_follow_remote_datasource.dart';
import '../../domain/repository/new_follow_repository.dart';
import '../cubit/upload_follow/upload_follow_cubit.dart';
import '../cubit/upload_follow/upload_follow_state.dart';
import '../widgets/data_textArea.dart';
import '../widgets/data_textfield.dart';
import '../widgets/upload_state_button.dart';

class NewFollowCasePage extends StatefulWidget {
  const NewFollowCasePage({super.key});

  @override
  MyNewFollowCasePage createState() => MyNewFollowCasePage();
}

class MyNewFollowCasePage extends State<NewFollowCasePage> {
  final TextEditingController _controllerFollowTitle = TextEditingController();
  final TextEditingController _controllerFollowInfo = TextEditingController();

  @override
  void dispose() {
    _controllerFollowTitle.dispose();
    _controllerFollowInfo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = FollowCaseDataSourceImpl();
    final repository = FollowCaseRepositoryImpl(remoteDataSource);

    final size = MediaQuery
        .of(context)
        .size;

    dynamic arguments = ModalRoute.of(context)?.settings.arguments;
    int casId = arguments['casId'];
    int docId = arguments['docId'];
    AuthUser authUser = arguments['AuthCredentials'];

    return BlocProvider(
        create: (_) => UploadFollowCubit(repository),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .appBarTheme
                .backgroundColor,
            automaticallyImplyLeading: true,
          ),
          body: Center(
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
                      Expanded(
                      child: Text(
                      'Agregar Seguimiento',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineSmall,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.040,
                        vertical: size.height * 0.010,
                      ),
                      child: CaseDataTextField(
                        contextRow: "Titulo del Seguimiento",
                        controllerData: _controllerFollowTitle,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.040,
                        vertical: size.height * 0.010,
                      ),
                      child: CaseDataTextArea(
                        contextRow: "Informacion del Seguimiento",
                        controllerData: _controllerFollowInfo,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.080,
                          vertical: size.height * 0.010,
                        ),
                        child: Text(
                          'Utilice este espacio para agregar un reporte de observaciones de como a visto la evolucion sintomatologica del paciente.',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium,
                          textAlign: TextAlign.justify,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.010),
                              child: UploadButton(
                                data: {
                                  'title': _controllerFollowTitle.text,
                                  'info': _controllerFollowInfo.text,
                                  'casId': casId,
                                  'docId': docId,
                                },
                                accessToken: authUser.accessToken,
                              ),
                            )
                          ],
                        )),
                    Expanded(
                      child: BlocBuilder<UploadFollowCubit, UploadFollowState>(
                          builder: (context, state) {
                            if (state is UploadFollowInitial) {
                              return Center(
                                  child: Text('Ingrese datos del paciente'));
                            } else if (state is UploadFollowLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is UploadFollowLoaded) {
                              Navigator.pop(context); // TODO CHECK
                              return Center(child: Text(
                                  'Datos subidos exitosamente')
                              );
                            } else if (state is UploadFollowError) {
                              return Center(child: Text(state.errorSMS));
                            }
                            return Container();
                          }
                      )),
                      ],
                    ),
                  ))),
        )),);
  }
}
