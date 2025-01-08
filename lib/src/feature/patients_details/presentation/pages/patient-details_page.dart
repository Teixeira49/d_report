import 'dart:io';

import 'package:d_report/src/feature/patients_details/data/datasource/remote/follow_case_remote_data_source.dart';
import 'package:d_report/src/feature/patients_details/data/repository/follow_case_repository.dart';
import 'package:d_report/src/feature/patients_details/presentation/cubit/file_generator/file_generator_cubit.dart';
import 'package:d_report/src/feature/patients_details/presentation/cubit/follow_report/follow_report_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

import '../../../../core/helpers/helpers.dart';
import '../../../../shared/data/model/view_details_status.dart';
import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/circular_progress_bar.dart';
import '../../../../shared/presentation/widget/floating_snack_bars.dart';

import '../../data/datasource/remote/all_case_remote_data_source.dart';
import '../../data/repository/case_repository.dart';

import '../../domain/entities/downloader_config.dart';
import '../../domain/usecases/download_record.dart';

import '../../domain/usecases/get_downloadable_follows.dart';
import '../cubit/assign_utils/assign_utils_cubit.dart';
import '../cubit/assign_utils/assign_utils_state.dart';
import '../cubit/file_generator/file_generator_state.dart';
import '../cubit/follow_report/follow_report_cubit.dart';
import '../cubit/patient_data/patient_data_cubit.dart';
import '../cubit/patient_data/patient_data_state.dart';

import '../widgets/card_patient_data.dart';
import '../widgets/config_downloader_panel.dart';
import '../widgets/custom_win_dialog.dart';
import '../widgets/follow_tile.dart';
import '../widgets/header_details.dart';

class PatientDetailsPage extends StatelessWidget {

  const PatientDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    //double sizeIcon = size.shortestSide * 0.50;

    DownloaderConfig downloaderConfig = DownloaderConfig(false, false, ValueNotifier(null));

    dynamic arguments =
        ModalRoute.of(context)?.settings.arguments; // TODO Refactor Rename

    int caseId = arguments['casKey'];
    String patFullName = arguments['patFullName'];
    AuthUser authUser = arguments["AuthCredentials"]; // TODO Rename
    User user = arguments["userData"];

    final patRemoteDataSource = AllCaseRemoteDataSourceImpl();
    final patRepository = PatientRepositoryImpl(patRemoteDataSource); // TODO Try to add in a Singleton

    final cafRemoteDataSource = FollowCaseRemoteDataSourceImpl();
    final cafRepository = FollowRepositoryImpl(cafRemoteDataSource);

    final DownloadPatientRecordUseCase downloadPatientRecordUseCase = DownloadPatientRecordUseCase();
    final GetDownloadableFollowsUseCase getDownloadableFollowsUseCase = GetDownloadableFollowsUseCase(cafRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                PatientDataCubit(patientRepositoryImpl: patRepository)
                  ..fetchCaseDetails(
                      caseId, user.userProfileId, authUser.accessToken)),
        BlocProvider(
            create: (_) =>
                FollowReportCubit(followRepositoryImpl: cafRepository)
                  ..fetchFollowCaseDetails(caseId, authUser.accessToken)),
        BlocProvider(
            create: (_) =>
                AssignUtilsCubit(patientRepositoryImpl: patRepository)),
        BlocProvider(create: (context) => FileGeneratorCubit(downloadPatientRecordUseCase, getDownloadableFollowsUseCase)),
      ], // TODO Rename
      child: DefaultTabController(
        length: 3,
        child: BlocBuilder<PatientDataCubit, PatientDataState>(
            builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: getTitleAppBar(state),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              automaticallyImplyLeading: true,
              actions: [
                Visibility(
                    visible: state is PatientDataLoaded ? state.permissionStatus != ViewDetailsStatus.GUEST : false,
                    child: BlocConsumer<FileGeneratorCubit, FileGeneratorState>(
                      listener: (subContext, stateDownload) async {
                        if (stateDownload is FileGeneratorLoaded) {
                          final bytes = await stateDownload.pdf.save();
                          var file = File('');
                          if (Platform.isIOS) {
                            final dir =
                                await getApplicationDocumentsDirectory();
                            file = File('${dir.path}/example.pdf');
                          }
                          if (Platform.isAndroid) {
                            //var status = await Permission.storage.status;
                            //print(status);
                            //if (status != Permission.storage.isGranted) {
                            //  status = (await Permission.storage.isGranted) as PermissionStatus;
                            //  openAppSettings();
                            //}
                            //if (status.isGranted) { // TODO Repair permission system
                            const downloadsFolderPath =
                                '/storage/emulated/0/Download/';
                            Directory dir = Directory(downloadsFolderPath);
                            file = File('${dir.path}/Informe${getTitleDocument(state)}${Helper.getCodeByDate()}.pdf');
                            //}
                          }
                          await file.writeAsBytes(bytes);
                          print("piña colada ${file.path}");
                        } else if (stateDownload is FileGeneratorFail) {
                          print(stateDownload.errorSMS);
                        }
                      },
                      builder: (subContext, stateDownload) {
                        return IconButton(
                            onPressed: () {
                              if (state is PatientDataLoaded){
                                configDownloaderPanel(subContext, downloaderConfig, () => subContext
                                    .read<FileGeneratorCubit>()
                                    .downloadFile(state.patient, state.caseReport, user, authUser, downloaderConfig.addDoctorSign, downloaderConfig.addPatientDetails, downloaderConfig.followController.value));
                              }
                            },
                            icon: const Icon(Icons.download));
                      },
                    ))
              ],
            ),
            body: NestedScrollView(
                headerSliverBuilder: (context, _) {
                  return [
                    SliverList(
                        delegate: SliverChildListDelegate([patientInfo(context, state, authUser, user, caseId, 3)]))
                  ];
                },
                body: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: "Paciente", icon: Icon(Icons.person)),
                        Tab(
                            text: "Resumen",
                            icon: Icon(Icons.library_books) //auto_stories
                            ),
                        Tab(text: "Seguimiento", icon: Icon(Icons.medication)),
                        //Tab(
                        //  text: "Seguimiento", Ordenes
                        //  icon: Icon(Icons.biotech) biotech
                        //),
                      ],
                    ),
                    Expanded(
                        child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: patientInfo(context, state, authUser, user, caseId, 1),
                        ),
                        SingleChildScrollView(
                          child: patientInfo(context, state, authUser, user, caseId, 2),
                        ),
                        SingleChildScrollView(
                          child: FollowInfo(patFullName),
                        )
                      ],
                    ))
                  ],
                )),
            floatingActionButton: _FloatingActionButtonForTab(
                casId: caseId, docId: 23, authUser: authUser), // TODO Delete Hardcode number
          );
        }),
      ),
    );
  }
}

class _FloatingActionButtonForTab extends StatelessWidget {
  final int casId;
  final int docId;
  final AuthUser authUser;

  const _FloatingActionButtonForTab({required this.casId, required this.docId, required this.authUser});

  @override
  Widget build(BuildContext context) {
    final TabController tabController = DefaultTabController.of(context);

    return AnimatedBuilder(
      animation: tabController,
      builder: (context, child) {
        return Visibility(
          visible: tabController.index == 2,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                  '/main/patients/details/create-follow-case',
                  arguments: {
                    'docId': docId,
                    'casId': casId,
                    'AuthCredentials': authUser
                  });
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

Widget getTitleAppBar(state){
  if (state is PatientDataLoaded) {
    return Text(
        '${state.patient.patName} ${state.patient.patLastname}');
  } else {
    return const Text("Detalles del Caso");
  }
}

String getTitleDocument(state){
  if (state is PatientDataLoaded) {
    return '-${state.caseReport.casEndFlag == true ? 'Egreso' : 'Avance'}-${state.patient.patName}-${state.patient.patLastname}-';
  } else {
    return "-Caso-";
  }
}

class FollowInfo extends StatelessWidget {
  const FollowInfo(this.patName, {super.key});

  final String patName;

  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context)?.settings.arguments;
    AuthUser authUser = arguments["AuthCredentials"];

    return BlocBuilder<FollowReportCubit, FollowReportState>(
        builder: (context, state) {
      if (state is FollowCaseInitial || state is FollowCaseLoading) {
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            CustomCircularProgressBar()
          ],
        );
      } else if (state is FollowCaseLoaded) {
        return ListView.builder(
          itemCount: state.followCase.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) =>
              FollowTile(context, state.followCase[index], patName, authUser)),
        );
      } else if (state is FollowCaseLoadedButEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.075,
                vertical: MediaQuery.of(context).size.height * 0.010,
              ),
              child: Text(state.sms),
            )
          ],
        );
      } else if (state is FollowCaseFail) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.075,
                vertical: MediaQuery.of(context).size.height * 0.010,
              ),
              child: Text(state.errorSMS),
            )
          ],
        );
      } else {
        return Container();
      }
    });
  }
}

Widget patientInfo(context, state, AuthUser authUser, User user, int caseId, int indexTab) {
/*class PatientInfo extends StatelessWidget {
  const PatientInfo(this.indexTab, {super.key});

  final int indexTab;

  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context)?.settings.arguments;
    AuthUser authUser = arguments["AuthCredentials"];
    User user = arguments["userData"];
    int caseId = arguments['casKey'];

    return BlocBuilder<PatientDataCubit, PatientDataState>(
        builder: (context, state) {
      print(context);*/
      if ((state is PatientDataInitial || state is PatientDataLoading) && indexTab != 3) {
        return Center(
            child: CircularProgressIndicator(
          // TODO MAKE GLOBAL
          color: Theme.of(context).colorScheme.primary,
        ));
      } else if (state is PatientDataLoaded && indexTab == 1) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomCardPatientRow(
              widgetKey: "Fecha de Nacimiento",
              widgetValue: state.patient.patBirthdayDate.toString(),
              tileIcon: Icons.calendar_month,
            ),
            Visibility(
              visible: state.patient.patDni != null,
              child: CustomCardPatientRow(
                widgetKey: "Doc Identidad",
                widgetValue: state.patient.patDni.toString(),
                tileIcon: Icons.perm_identity,
              ),
            ),
            CustomCardPatientRow(
              widgetKey: "Doc Identidad Representante",
              widgetValue: state.patient.patGuardianDni.toString(),
              tileIcon: Icons.family_restroom,
            ),
            CustomCardPatientRow(
              widgetKey: "Genero",
              widgetValue: state.patient.patGender.toString(),
              tileIcon: state.patient.patGender.toString() == "Male"
                  ? Icons.male
                  : (state.patient.patGender.toString() == "Female"
                      ? Icons.female
                      : Icons.circle_outlined),
            ),
            CustomCardPatientRow(
              widgetKey: "Tipo de Sangre",
              widgetValue: 'Grupo ${state.patient.patBloodType}',
              tileIcon: Icons.water_drop,
            ),
          ],
        );
      } else if (state is PatientDataLoaded && indexTab == 2) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomCardPatientRow(
              widgetKey: "Habitacion",
              widgetValue: state.caseReport.casActualRoom.toString(),
              tileIcon: Icons.door_front_door,
            ),
            CustomCardPatientRow(
              widgetKey: "Fecha de Ingreso",
              widgetValue: Helper.getDateSMSByString(state.caseReport.casEnterDate.toString()),
              tileIcon: Icons.date_range,
            ),
            CustomCardPatientRow(
              widgetKey: "Sintomatologia",
              widgetValue: state.caseReport.casSymptomatology.toString(),
              tileIcon: Icons.local_hospital,
            ),
            CustomCardPatientRow(
              widgetKey: "Diagnostico Inicial",
              widgetValue: state.caseReport.casDiagnosis.toString(),
              tileIcon: Icons.summarize,
            ),
            CustomCardPatientRow(
              widgetKey: "Area de Ingreso del Caso",
              widgetValue: 'Modulo de ${state.caseReport.casEntryArea}',
              tileIcon: Icons.local_hospital,
            ),
            CustomCardPatientRow(
              widgetKey: "Origen de ingreso del paciente",
              widgetValue: state.caseReport.casMethodOfEntry.toString(),
              tileIcon: Icons.people,
            ),
            Visibility(
              visible: state.caseReport.casEndFlag == true,
              child: CustomCardPatientRow(
                widgetKey: "Fecha de Cierre",
                widgetValue: state.caseReport.casEndDate == null ? '' : Helper.getDateSMSByString(state.caseReport.casEndDate.toString()),
                tileIcon: Icons.date_range,
              ),
            ),
            Visibility(
              visible: state.caseReport.casEndFlag == true,
              child: CustomCardPatientRow(
                widgetKey: "Diagnostico de Salida",
                widgetValue: state.caseReport.casEndDiagnosis.toString(),
                tileIcon: Icons.summarize,
              ),
            ),
          ],
        );
      } else if (state is PatientDataLoaded && indexTab == 3) {
        return Row(children: [
          HeaderDetails(
              context,
              MediaQuery.of(context).size,
              '${state.patient.patName} ${state.patient.patLastname}',
              state.patient.patBirthdayDate,
              state.caseReport.casEndReason),
          const Spacer(),
          BlocConsumer<AssignUtilsCubit, AssignUtilsState>(
              listener: (miniContext, miniState) {
            if (miniState is AssignUtilsLoaded) {
              Navigator.pop(miniContext);
              FloatingSnackBar.show(
                  miniContext, 'Se ha retirado del caso correctamente');
            } else if (miniState is AssignUtilsFail) {
              FloatingWarningSnackBar.show(miniContext, miniState.errorSMS);
            }
          }, builder: (miniContext, miniState) {
            return Row(
              children: [
                Visibility(
                  visible: state.permissionStatus != ViewDetailsStatus.GUEST,
                  child: TextButton(
                    onPressed: () {
                      customWindowDialog(
                        context,
                        () => (miniContext
                            .read<AssignUtilsCubit>()
                            .fetchEndAssignDetails(caseId, user.userProfileId,
                                authUser.accessToken)),
                      );
                    },
                    child: const Text('Desvincular'),
                  ),
                ),
                Visibility(
                    visible: state.permissionStatus == ViewDetailsStatus.GUEST,
                    child: TextButton(
                        onPressed: () { // TODO MAKE A INDIVIDUAL WIDGET
                          showDialog(
                            context: miniContext,
                            builder: (BuildContext subContext) =>
                                AlertDialog(
                              title: const Text("Agregar caso"),
                              backgroundColor: Theme.of(subContext)
                                  .scaffoldBackgroundColor,
                              content: const Text(
                                "Pulsar esta opcion agregara a tu ventana principal el monitoreo de este caso, ¿Seguro que desea continuar?",
                                textAlign: TextAlign.justify,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(subContext);
                                    },
                                    child: Text(
                                      'Cancelar',
                                      style: TextStyle(
                                          color: Theme.of(subContext)
                                              .colorScheme
                                              .secondary),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(subContext);
                                      miniContext
                                          .read<AssignUtilsCubit>()
                                          .createNewAssign(
                                              caseId,
                                              user.userProfileId,
                                              authUser.accessToken);
                                    },
                                    child: Text('Confirmar'))
                              ],
                            ),
                          );
                        },
                        child: const Text('Vincular'))),
                Visibility(
                    visible: (state.caseReport.casEndFlag != true) &&
                        state.permissionStatus != ViewDetailsStatus.GUEST,
                    child: Container(
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Advertencia"),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              content: const Text(
                                "Finalizar el caso evitara que se puedan seguir haciendo operaciones, ¿Seguro que desea continuar?",
                                textAlign: TextAlign.justify,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Cancelar',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.of(context).pushNamed(
                                          '/main/patients/details/end-case',
                                          arguments: {
                                            'authCredentials': authUser,
                                            'patName':
                                                '${state.patient.patName} ${state.patient.patLastname}',
                                            'patId': state.patient.patId,
                                            'casKey': caseId,
                                          });
                                    },
                                    child: Text('Confirmar'))
                              ],
                            ),
                          );
                        },
                        child: const Text('Finalizar'),
                      ),
                    )),
                Visibility(
                    visible: state.caseReport.casEndFlag == true &&
                        authUser.roleId == 3 &&
                        state.permissionStatus != ViewDetailsStatus.GUEST,
                    child: Container(
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Aviso"),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              content: const Text(
                                "Al ejecutar esta accion, se reabrira el caso, y todos los ultimos asignados volveran a verlo en sus cuentas",
                                textAlign: TextAlign.justify,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Cancelar',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Confirmar'))
                              ],
                            ),
                          );
                        },
                        child: const Text('Reabrir Caso'),
                      ),
                    )),
              ],
            );
          })
        ]);
      } else {
        return Container();
      }
    //});
  //}
}
