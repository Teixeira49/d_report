import 'package:d_report/src/core/utils/constants/fields_constants.dart';
import 'package:d_report/src/feature/patient_case_follow_details/data/datasource/remote/follow_case_remote_data_source.dart';
import 'package:d_report/src/feature/patient_case_follow_details/domain/repository/follow_detailed_case_repository.dart';
import 'package:d_report/src/feature/patient_case_follow_details/presentation/cubit/follow_report/follow_detailed_report_cubit.dart';
import 'package:d_report/src/feature/patient_case_follow_details/presentation/cubit/follow_report/follow_detailed_report_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/card_patient_summary.dart';

class PatientFollowCaseDetailsPage extends StatelessWidget {
  const PatientFollowCaseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    final cafId = argument['cafId'];

    final cafDetailedRemoteDataSource = FollowCaseDetailsRemoteDataSourceImpl();
    final followDetailedRepositoryImpl = FollowDetailedRepositoryImpl(cafDetailedRemoteDataSource);

    return BlocProvider(
      create: (_) => FollowDetailedReportCubit(followDetailedRepositoryImpl: followDetailedRepositoryImpl)..fetchFollowCaseDetails(cafId),
      child: Scaffold(
          appBar: AppBar(
            title: Row(children: [
              const Spacer(),
              const Text("Seguimiento "),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  print('editar');

                  //Navigator.of(context).pushNamed('/main/profile/edit-row', arguments: {
                  //  'userData': argument["userData"],
                  //  'doctorData': doctor,
                  //});
                },
              )
            ]),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            automaticallyImplyLeading: true,
          ),
          body: SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: size.height * 0.25,
                    ),
                    child: IntrinsicHeight(
                        child: BlocBuilder<FollowDetailedReportCubit, FollowDetailedReportState>(
                          builder: (context, state) {
                            return _buildDetailRows(context, cafId, state);
                          }
                      )
                ),
              )
          )
      ),
    );
  }

  Widget _buildDetailRows(context, cafId, FollowDetailedReportState state){
    if (state is FollowDetailedCaseInitial) {
      return Center(child: CircularProgressIndicator( // TODO MAKE GLOBAL
        color: Theme.of(context).colorScheme.primary,
      ));
    } else if (state is FollowDetailedCaseLoaded) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.followDetailedCase.cafReportTitle, style: Theme.of(context).textTheme.titleLarge,),
          SizedBox(height: 10,),
          CustomCardResumeRow(widgetKey: "Reporte Emitido",
            widgetValue: state.followDetailedCase.cafReportDate == state.followDetailedCase.cafReportUpdateTime ?
            state.followDetailedCase.cafReportDate : '${state.followDetailedCase.cafReportDate} (Actualizado: ${state.followDetailedCase.cafReportUpdateTime})',),
          CustomCardResumeRow(widgetKey: "Autor del Reporte", widgetValue: '${state.followDetailedCase.docFullName} (${state.followDetailedCase.docSpecialty})',),
          CustomCardResumeRow(widgetKey: "Informacion", widgetValue: state.followDetailedCase.cafReportInfo,),
        ],
      );
    } else if (state is FollowDetailedCaseFail) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/not_found_logo.png",
          ),
          Text(state.errorSMS, style: Theme.of(context).textTheme.headlineSmall,),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await context.read<FollowDetailedReportCubit>().refreshGetCaseFollowsByCase(cafId);
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
