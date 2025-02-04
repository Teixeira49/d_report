import 'package:d_report/src/shared/presentation/widget/bullet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/styles/static_colors.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../../../../shared/presentation/widget/loading_show_dialog.dart';
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

    final size = MediaQuery.of(context).size;
    final keyboardEnabled = MediaQuery.of(context).viewInsets.bottom;

    dynamic arguments = ModalRoute.of(context)?.settings.arguments;
    int casId = arguments['casId'];
    int docId = arguments['docId'];
    String patName = arguments['patName'];
    AuthUser authUser = arguments['AuthCredentials'];

    return BlocProvider(
        create: (_) => UploadFollowCubit(repository),
        child: BlocConsumer<UploadFollowCubit, UploadFollowState>(
          listener: (context, state) {

            if (state is UploadFollowLoading) {
              LoadingShowDialog.show(context, 'Subiendo Informacion');
            } else if (state is UploadFollowLoaded) {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 100), () {
                FloatingSnackBar.show(
                    context,
                    'Informe guardado con exito.',
                    Icons.check,
                    ColorPalette.checkColor);
                Navigator.pop(context);
              });
            } else if (state is UploadFollowError) {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 100), () {
                FloatingWarningSnackBar.show(
                    context, state.errorSMS);
              });
            } else if (state is UploadWithoutChanges) {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 100), () {
                FloatingWarningSnackBar.show(
                    context, state.errorSMS);
              });
            }
          }, builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  automaticallyImplyLeading: true,
                  title: Text(patName),
                  actions: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Evolucion Clinica"),
                              backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              content: const Text(
                                "La evolucion clinica son reportes en donde usted describe el como a visto los avances sintomatologicos del paciente, explicando puntualmente el su progresion en el caso.",
                                textAlign: TextAlign.justify,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {Navigator.pop(context);},
                                    child: const Text('Entendido'))
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.question_mark))
                  ],
                ),
                body: Center(
                  child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: size.height * 0.25,
                          ),
                          child: IntrinsicHeight(
                              child: Container(
                            margin: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(24),
                                  child: Text(
                                    'Nueva Evolucion del caso',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: size.height * 0.015,
                                  ),
                                  child: CaseDataTextField(
                                    contextRow: "Titulo de la Nota",
                                    controllerData: _controllerFollowTitle,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: size.height * 0.015,
                                  ),
                                  child: CaseDataTextArea(
                                    contextRow: "Descripcion de la Evolucion",
                                    controllerData: _controllerFollowInfo,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.020,
                                    vertical: size.height * 0.010,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const BulletDecorator(
                                          sizeBullet: 5,
                                          marginHorizontal: 5,
                                          marginVertical: 7.5),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Utilice este espacio para agregar sus observaciones de la evolucion sintomatologica del paciente.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 120,
                                ),
                              ],
                            ),
                          )))),
                ),
                bottomSheet: Visibility(
                    visible: keyboardEnabled == 0,
                    child: UploadButton(
                        selected: 1,
                        size: size,
                        endEdit: () {
                          if (_controllerFollowTitle.text.isNotEmpty && _controllerFollowInfo.text.isNotEmpty) {
                          context
                              .read<UploadFollowCubit>()
                              .postUploadFollowData({
                            'title': Helper.capitalize(_controllerFollowTitle.text, false),
                            'info': Helper.capitalize(_controllerFollowInfo.text, false),
                            'casId': casId,
                            'docId': docId,
                          }, authUser.accessToken);
                        } else {
                            FloatingWarningSnackBar.show(context, 'Faltan Campos por rellenar');
                          }
                        })
                    ));
          },
        ));
  }
}