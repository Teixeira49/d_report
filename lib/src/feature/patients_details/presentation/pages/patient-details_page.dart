import 'package:d_report/src/feature/patients_details/data/datasource/remote/follow_case_remote_data_source.dart';
import 'package:d_report/src/feature/patients_details/data/repository/follow_case_repository.dart';
import 'package:d_report/src/feature/patients_details/presentation/cubit/follow_report/follow_report_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../data/datasource/remote/all_case_remote_data_source.dart';
import '../../data/repository/patient_repository.dart';
import '../cubit/follow_report/follow_report_cubit.dart';
import '../cubit/patient_data/patient_data_cubit.dart';
import '../cubit/patient_data/patient_data_state.dart';
import '../widgets/card_patient_data.dart';
import '../widgets/follow_tile.dart';
import '../widgets/header_details.dart';

class PatientDetailsPage extends StatelessWidget {

  const PatientDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    //double sizeIcon = size.shortestSide * 0.50;

    dynamic arguments =
        ModalRoute.of(context)?.settings.arguments; // TODO Refactor Rename

    int caseId = arguments['casKey'];
    String patFullName = arguments['patFullName'];
    AuthUser authUser = arguments["AuthCredentials"];

    final size = MediaQuery.of(context).size;

    final patRemoteDataSource = AllCaseRemoteDataSourceImpl();
    final patRepository = PatientRepositoryImpl(patRemoteDataSource);

    final cafRemoteDataSource = FollowCaseRemoteDataSourceImpl();
    final cafRepository = FollowRepositoryImpl(cafRemoteDataSource);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                PatientDataCubit(patientRepositoryImpl: patRepository)
                  ..fetchCaseDetails(caseId, authUser.accessToken)),
        BlocProvider(
            create: (_) =>
                FollowReportCubit(followRepositoryImpl: cafRepository)
                  ..fetchFollowCaseDetails(caseId, authUser.accessToken)),
      ],
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Detalles del Caso"),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              centerTitle: true,
              automaticallyImplyLeading: true,
            ),
            body: NestedScrollView(
                headerSliverBuilder: (context, _) {
                  return [
                    SliverList(
                        delegate: SliverChildListDelegate([
                      /*HeaderDetails(
                        context,
                        size,
                        caseId.toString(),
                        caseId,
                    ),*/
                      PatientInfo(3)
                    ]))
                  ];
                },
                body: Column(
                  children: [
                    TabBar(
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
                        /*
                          SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10,),
                                  CustomCardPatientRow(
                                    widgetKey: "Fecha de Nacimiento",
                                    widgetValue: '25-11-2007',
                                    tileIcon: Icons.calendar_month,
                                  ),
                                  CustomCardPatientRow(
                                    widgetKey: "Doc Identidad",
                                    widgetValue: '123124124',
                                    tileIcon: Icons.perm_identity,
                                  ),
                                  CustomCardPatientRow(
                                    widgetKey: "Doc Identidad Representante",
                                    widgetValue: '12312412',
                                    tileIcon: Icons.family_restroom,
                                  ),
                                  CustomCardPatientRow(
                                    widgetKey: "Genero",
                                    widgetValue: 'Hombre',
                                    tileIcon: Icons.male,
                                  ),
                                  CustomCardPatientRow(
                                    widgetKey: "Tipo de Sangre",
                                    widgetValue: 'Grupo A+',
                                    tileIcon: Icons.water_drop,
                                  ),
                                ]
                            ),
                          ),*/
                        SingleChildScrollView(
                          child: PatientInfo(1),
                        ),
                        SingleChildScrollView(
                          child: PatientInfo(2),

                          /*Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomCardResumeRow(
                                    widgetKey: "Habitacion",
                                    widgetValue: 'A3 - 302',
                                  ),
                                  CustomCardResumeRow(
                                    widgetKey: "Fecha de Ingreso",
                                    widgetValue: 'Grupo A+',
                                  ),
                                  CustomCardResumeRow(
                                    widgetKey: "Sintomatologia",
                                    widgetValue: 'Grupo A+',
                                  ),
                                  CustomCardResumeRow(
                                    widgetKey: "Diagnostico inicial",
                                    widgetValue: 'MuchoTexto',
                                  ),
                                  CustomCardResumeRow(
                                    widgetKey: "Fecha Fin del Caso",
                                    widgetValue: 'Grupo A+',
                                  ),
                                  CustomCardResumeRow(
                                    widgetKey: "Diagnostico final",
                                    widgetValue: 'Grupo A+',
                                  ),
                                ],
                              )*/
                        ),
                        SingleChildScrollView(
                          child: FollowInfo(patFullName),
                          /*Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 5,),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.075,
                                        vertical: size.height * 0.010,
                                      ),
                                      child: TextField(

                                      ),
                                    ),
                                    ListView.builder(
                                        itemCount: pepe.length,
                                        shrinkWrap: true,
                                        itemBuilder: (
                                                (context, index) => FollowTile(context, 'a')
                                        )
                                    )
                                  ]
                              )*/
                        )
                      ],
                    ))
                  ],
                )),
            floatingActionButton: _FloatingActionButtonForTab(casId: caseId, docId: 23), // TODO Delete Hardcode number
          )),
    );
  }
}

class _FloatingActionButtonForTab extends StatelessWidget {
  final int casId;
  final int docId;

  _FloatingActionButtonForTab({required this.casId, required this.docId});

  @override
  Widget build(BuildContext context) {

    final TabController tabController = DefaultTabController.of(context)!;

    dynamic arguments =
        ModalRoute.of(context)?.settings.arguments;
    AuthUser authUser = arguments["AuthCredentials"];

    return AnimatedBuilder(
      animation: tabController,
      builder: (context, child) {
        return Visibility(
          visible: tabController.index == 2,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                  '/main/patients/details/create-follow-case',
                  arguments: {'docId': docId, 'casId': casId, 'AuthCredentials': authUser});
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class FollowInfo extends StatelessWidget {
  const FollowInfo(this.patName, {super.key});

  final String patName;

  @override
  Widget build(BuildContext context) {

    dynamic arguments =
        ModalRoute.of(context)?.settings.arguments;
    AuthUser authUser = arguments["AuthCredentials"];

    return BlocBuilder<FollowReportCubit, FollowReportState>(
        builder: (context, state) {
      if (state is FollowCaseInitial) {
        return Center(
            child: CircularProgressIndicator(
          // TODO MAKE GLOBAL
          color: Theme.of(context).colorScheme.primary,
        ));
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

class PatientInfo extends StatelessWidget {
  const PatientInfo(this.indexTab, {super.key});

  final int indexTab;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientDataCubit, PatientDataState>(
        builder: (context, state) {
      if (state is PatientDataInitial) {
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
            CustomCardPatientRow(
              widgetKey: "Doc Identidad",
              widgetValue: state.patient.patDni.toString(),
              tileIcon: Icons.perm_identity,
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
              widgetValue: state.caseReport.casEnterDate.toString(),
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
              tileIcon: Icons.local_hospital,
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
          ],
        );
      } else if (state is PatientDataLoaded && indexTab == 3) {
        return HeaderDetails(
            context,
            MediaQuery.of(context).size,
            '${state.patient.patName} ${state.patient.patLastname}',
            state.patient.patBirthdayDate,
            state.caseReport.casEndReason);
      } else {
        return Container();
      }
    });
  }
}
