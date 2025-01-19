import 'dart:io';

import 'package:d_report/src/feature/patient_case_follow_details/data/datasource/remote/follow_case_remote_data_source.dart';
import 'package:d_report/src/feature/patient_case_follow_details/domain/repository/follow_detailed_case_repository.dart';
import 'package:d_report/src/feature/patient_case_follow_details/domain/use_cases/download_record.dart';
import 'package:d_report/src/feature/patient_case_follow_details/presentation/cubit/follow_report/follow_detailed_report_cubit.dart';
import 'package:d_report/src/feature/patient_case_follow_details/presentation/cubit/follow_report/follow_detailed_report_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/helpers/helpers.dart';
import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/presentation/widget/circular_progress_bar.dart';
import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../../../../shared/presentation/widget/loading_show_dialog.dart';
import '../../domain/entities/downloader_config.dart';
import '../cubit/file_generator/file_generator_cubit.dart';
import '../cubit/file_generator/file_generator_state.dart';
import '../widgets/card_patient_summary.dart';
import '../widgets/config_downloader_panel.dart';

class PatientFollowCaseDetailsPage extends StatelessWidget {
  const PatientFollowCaseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    DownloaderConfig downloaderConfig = DownloaderConfig(false, false);

    final size = MediaQuery.of(context).size;
    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    final cafId = argument['cafId'];
    final patFullName = argument['patFullName'];
    final patDetails = argument['patientDetails'];
    AuthUser authUser = argument["AuthCredentials"];

    final cafDetailedRemoteDataSource = FollowCaseDetailsRemoteDataSourceImpl();
    final followDetailedRepositoryImpl =
        FollowDetailedRepositoryImpl(cafDetailedRemoteDataSource);

    final DownloadCaseFollowRecordUseCase downloadCaseFollowRecordUseCase =
        DownloadCaseFollowRecordUseCase();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => FollowDetailedReportCubit(
                followDetailedRepositoryImpl: followDetailedRepositoryImpl)
              ..fetchFollowCaseDetails(cafId, authUser.accessToken)),
        BlocProvider(
            create: (context) =>
                FileGeneratorCubit(downloadCaseFollowRecordUseCase))
      ],
      child: BlocBuilder<FollowDetailedReportCubit, FollowDetailedReportState>(
          builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Detalles de Evolucion'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    print('editar');

                    //Navigator.of(context).pushNamed('/main/profile/edit-row', arguments: {
                    //  'userData': argument["userData"],
                    //  'doctorData': doctor,
                    //});
                  },
                ),
                Visibility(
                    visible: state is FollowDetailedCaseLoaded,
                    child: BlocConsumer<FileGeneratorCubit, FileGeneratorState>(
                        listener: (subContext, subState) async {
                      if (subState is FileGeneratorLoading) {
                        LoadingShowDialog.show(context, 'Descargando Archivo');
                      }
                      if (subState is FileGeneratorLoaded) {
                        final bytes = await subState.pdf.save();
                        var file = File('');
                        if (Platform.isIOS) {
                          final dir = await getApplicationDocumentsDirectory();
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
                          file = File(
                              '${dir.path}/Seguimiento-${patFullName.toString()}-${Helper.getCodeByDate()}.pdf');
                          //}
                        }
                        await file.writeAsBytes(bytes);
                        Navigator.of(context, rootNavigator: true).pop();
                        FloatingSnackBar.show(subContext, 'Informe guardado con exito.', Icons.check, Colors.green); // TODO Safe color in styes folder
                      } else if (subState is FileGeneratorFail) {
                        FloatingWarningSnackBar.show(subContext, subState.errorSMS);
                      }
                    }, builder: (subContext, subState) {
                      return IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () async {
                            print('editar');
                            if (state is FollowDetailedCaseLoaded) {
                              print('a');
                              configDownloaderPanel(
                                  subContext,
                                  downloaderConfig,
                                  () => subContext
                                      .read<FileGeneratorCubit>()
                                      .downloadFile(
                                          state.followDetailedCase,
                                          downloaderConfig,
                                          patFullName,
                                          (patDetails)));
                            }
                          });
                    }))
              ],
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              automaticallyImplyLeading: true,
            ),
            body: SingleChildScrollView(
                child: _buildDetailRows(context, cafId, patFullName, state)));
      }),
    );
  }

  Widget _buildDetailRows(
      context, cafId, patFullName, FollowDetailedReportState state) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    AuthUser authUser = argument["AuthCredentials"];
    final patDetails = argument['patientDetails'];

    if (state is FollowDetailedCaseInitial) {
      return const Center(child: CustomCircularProgressBar());
    } else if (state is FollowDetailedCaseLoaded) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            state.followDetailedCase.cafReportTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          ListView(
            shrinkWrap: true,
            children: [
              const Divider(
                indent: 20.4,
                endIndent: 20.4,
                color: Colors.black,
              ),
              CustomCardResumeRow(
                widgetKey: "Paciente",
                widgetValue:
                    '$patFullName ${(patDetails != null) ? '(Edad: ${Helper.getAgeByDateInString(patDetails['birthday'])} Años)' : ''}',
              ),
              CustomCardResumeRow(
                widgetKey: "Reporte Emitido",
                widgetValue: state.followDetailedCase.cafReportDate ==
                        state.followDetailedCase.cafReportUpdateTime
                    ? state.followDetailedCase.cafReportDate
                    : '${state.followDetailedCase.cafReportDate} (Actualizado: ${state.followDetailedCase.cafReportUpdateTime})',
              ),
              CustomCardResumeRow(
                widgetKey: "Autor del Reporte",
                widgetValue:
                    '${state.followDetailedCase.docFullName} (${state.followDetailedCase.docSpecialty})',
              ),
              const Divider(
                indent: 20.4,
                endIndent: 20.4,
                color: Colors.black,
              ),
              (patDetails != null)
                  ? CustomCardResumeRow(
                      widgetKey: "Caracteristicas del paciente",
                      widgetValue:
                          'Peso: ${Helper.writeWeightByInt(patDetails['patWeight'])} kg  -  Estatura: ${Helper.writeHeightByInt(patDetails['patHeight'])} m\nGrupo Sanguineo: ${patDetails['bloodType']}',
                    )
                  : Container(),
              CustomCardResumeRow(
                widgetKey: "Informacion del Seguimiento",
                widgetValue: state.followDetailedCase.cafReportInfo,
              ),
            ],
          )
        ],
      );
    } else if (state is FollowDetailedCaseFail) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/not_found_logo.png",
          ),
          Text(
            state.errorSMS,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await context
                  .read<FollowDetailedReportCubit>()
                  .refreshGetCaseFollowsByCase(cafId, authUser.accessToken);
            },
            child: const Text('Reintentar'),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
