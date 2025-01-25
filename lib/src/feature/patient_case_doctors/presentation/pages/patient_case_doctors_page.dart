import 'package:d_report/src/feature/patient_case_doctors/data/datasource/remote/case_doctor_remote_%20data_source.dart';
import 'package:d_report/src/feature/patient_case_doctors/data/repository/case_doctors_repository.dart';
import 'package:d_report/src/feature/patient_case_doctors/domain/use_cases/fetch_doctors.dart';
import 'package:d_report/src/feature/patient_case_doctors/presentation/cubit/view_doctors/view_doctors_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/circular_progress_bar.dart';
import '../cubit/view_doctors/view_doctors_cubit.dart';
import '../widgets/doctor_case_tile.dart';
import '../widgets/refresh_button.dart';

class PatientCaseDoctorsPage extends StatelessWidget {
  const PatientCaseDoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    final size = MediaQuery.of(context).size;

    int caseId = argument['casKey'];
    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    final CaseDoctorRemoteDataSourceImpl caseDoctorRemoteDataSourceImpl =
        CaseDoctorRemoteDataSourceImpl();
    final CaseDoctorRepositoryImpl caseDoctorRepositoryImpl =
        CaseDoctorRepositoryImpl(caseDoctorRemoteDataSourceImpl);
    final FetchDoctorsUseCase fetchDoctorsUseCase =
        FetchDoctorsUseCase(caseDoctorRepositoryImpl);

    return BlocProvider(
      create: (_) => ViewDoctorsCubit(fetchDoctorsUseCase)
        ..getDoctors(caseId, authUser.accessToken),
      child: BlocBuilder<ViewDoctorsCubit, ViewDoctorsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Doctores en el Caso',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              automaticallyImplyLeading: true,
              centerTitle: false,
            ),
            body: SafeArea(
              child: bodyPatientCaseDoctors(
                  context, state, caseId, user, authUser, size),
            ),
          );
        },
      ),
    );
  }

  Widget bodyPatientCaseDoctors(BuildContext context, ViewDoctorsState state,
      int caseId, User user, AuthUser authUser, Size size) {
    if (state is ViewDoctorsInitial || state is ViewDoctorsLoading) {
      return const Center(
          child: CustomCircularProgressBar(
        labelText: 'Buscando Doctores',
      ));
    } else if (state is ViewDoctorsLoaded) {
      final filteredCases = state.listAssignedDoctors
          .where((docItem) =>
              '${docItem.docName} ${docItem.docLastName} ${docItem.docSpeciality}'
                  .toLowerCase()
                  .contains(state.filter.toLowerCase()))
          .toList();
      return GestureDetector(
        onVerticalDragDown: (DragDownDetails details) {
          if (details.globalPosition.dy < 50) {
            context
                .read<ViewDoctorsCubit>()
                .getDoctors(caseId, authUser.accessToken);
          }
        },
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
            itemCount: filteredCases.length,
            itemBuilder: (context, index) =>
                DoctorCaseTile(filteredCases[index], authUser, user)),
      );
    } else if (state is ViewDoctorsWithoutUpdate) {
      return Center(child: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¡Algo ha salido Mal!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 360,
                    child: Image.asset(
                      "assets/images/not_found_logo.png",
                    ),
                  ),
                  Text(
                    state.errorSMS,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  RefreshElevatedButton(
                    size: size,
                    function: () async {
                      await context
                          .read<ViewDoctorsCubit>()
                          .getDoctors(caseId, authUser.accessToken);
                    },
                  ),
                ],
              ))));
    } else if (state is ViewDoctorsTimeout) {
      return Center(child: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¡Algo ha salido Mal!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 360,
                    child: Image.asset(
                      "assets/images/not_found_logo.png",
                    ),
                  ),
                  Text(
                    state.sms,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  RefreshElevatedButton(
                    size: size,
                    function: () async {
                      await context
                          .read<ViewDoctorsCubit>()
                          .getDoctors(caseId, authUser.accessToken);
                    },
                  ),
                ],
              ))));
    } else if (state is ViewDoctorsFail) {
      return Center(child: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¡Algo ha salido Mal!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 360,
                    child: Image.asset(
                      "assets/images/not_found_logo.png",
                    ),
                  ),
                  Text(
                    state.errorSMS,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  RefreshElevatedButton(
                    size: size,
                    function: () async {
                      await context
                          .read<ViewDoctorsCubit>()
                          .getDoctors(caseId, authUser.accessToken);
                    },
                  ),
                ],
              ))));
    } else {
      return Container();
    }
  }
}
