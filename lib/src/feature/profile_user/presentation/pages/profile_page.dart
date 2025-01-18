import 'package:d_report/src/feature/profile_user/data/datasource/remote/profile_remote_data_source.dart';
import 'package:d_report/src/feature/profile_user/data/repositories/profile_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/helpers.dart';
import '../../../../shared/data/model/roles.dart';
import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/circular_progress_bar.dart';
import '../../../../shared/presentation/widget/drawer.dart';
import '../../domain/entities/doctor.dart';
import '../cubit/profile_data/profile_data_cubit.dart';
import '../cubit/profile_data/profile_data_state.dart';
import '../widgets/custom_card_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  MyProfilePageState createState() => MyProfilePageState();
}

class MyProfilePageState extends State<ProfilePage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final profileDataSource = ProfileRemoteDataSourceImpl();
    final repository =
        ProfileRepositoryImpl(profileRemoteDataSource: profileDataSource);

    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    Doctor doctor = Doctor(
        id: 1,
        firstName: "pepe",
        lastName: "Gonzales",
        dni: 123124,
        birthday: "25-10-1980",
        genre: "Male",
        range: "Doctor",
        speciality: "Bacteriologo");

    return BlocProvider(
      create: (_) => ProfileDataCubit(profileRepositoryImpl: repository)..getDoctorProfile(user.userProfileId, authUser.accessToken),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text("Perfil"),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                print(user.userName);
                print(user.userRoleUid);
                print(user.userEmail);
                Navigator.of(context)
                    .pushNamed('/main/profile/edit-row', arguments: {
                  'userData': argument["userData"],
                  'doctorData': doctor,
                });
              },
            )
          ],
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          automaticallyImplyLeading: true,
        ),
        drawer: NavigatorDrawer(
          user: user,
          authUser: authUser,
        ),
        body: BlocBuilder<ProfileDataCubit, ProfileDataState>(
            builder: (context, state) {
          if (state is ProfileDataInitial || state is ProfileDataLoading) {
            return const Center(
              child: CustomCircularProgressBar(),
            );
          } else if (state is ProfileDataLoaded) {
            return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ProfileDataCubit>()
                      .refreshProfile(user.userProfileId, authUser.accessToken);
                },
                child: Center(
                    child: ListView(
                  children: [
                    Container(
                      height: 225,
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(children: [
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              child: Image.asset("assets/images/logo.png"),
                            ),
                          ]),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${Helper.capitalize(UserRole.values[authUser.roleId].name)}. ${user.userName}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            user.userEmail,
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      ),
                    ),
                    CustomCardProfileRow(
                      defaultKey: "Nombre",
                      defaultValue: "${state.doctor.firstName} ${state.doctor.lastName}",
                    ),
                    CustomCardProfileRow(
                      defaultKey: "Cedula",
                      defaultValue: state.doctor.dni.toString(),
                    ),
                    CustomCardProfileRow(
                      defaultKey: "Cumpleaños",
                      defaultValue: state.doctor.birthday,
                    ),
                    CustomCardProfileRow(
                      defaultKey: "Genero",
                      defaultValue: state.doctor.genre,
                    ),
                    CustomCardProfileRow(
                      defaultKey: "Especialidad",
                      defaultValue: "Doctor - ${state.doctor.speciality}",
                    ),
                    CustomCardProfileRow(
                      defaultKey: "ID Usuario",
                      defaultValue: state.doctor.id.toString(),
                    ),
                  ],
                )));
          } else if (state is ProfileDataFail) {
            print('pote');
            return Container();
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
