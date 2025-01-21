import 'package:d_report/src/core/utils/constants/fields_constants.dart';
import 'package:d_report/src/feature/profile_user/data/datasource/remote/profile_remote_data_source.dart';
import 'package:d_report/src/feature/profile_user/data/repositories/profile_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../my_flutter_app_icons.dart';
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

    final size = MediaQuery.of(context).size;
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
      create: (_) => ProfileDataCubit(profileRepositoryImpl: repository)
        ..getDoctorProfile(user.userProfileId, authUser.accessToken),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text("Perfil"),
          actions: [
            BlocBuilder<ProfileDataCubit, ProfileDataState>(
                builder: (context, state) {
              if (state is ProfileDataLoaded) {
                return IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/main/profile/edit-row', arguments: {
                      'userData': argument["userData"],
                      'doctorData': doctor,
                    });
                  },
                );
              } else {
                return Container();
              }
            }),
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
            return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ProfileDataCubit>()
                      .refreshProfile(user.userProfileId, authUser.accessToken);
                },
                child: ListView(children: [
                  Container(
                    height: 225,
                    decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 11,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(children: [
                          CircleAvatar(
                            radius: 65.0,
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
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
                        ),
                      ],
                    ),
                  ),
                   Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisSize: MainAxisSize.max,
                       children: [
                         SizedBox(height: size.height / 4,),
                         const CustomCircularProgressBar(),
                       ],
                     ),


                ]));
          } else if (state is ProfileDataLoaded) {
            String genreTranslated =
                translateGenreType[state.doctor.genre] ?? 'Indefinido';
            IconData gender;
            switch (state.doctor.genre) {
              case 'Male':
                gender = Icons.male;
                break;
              case 'Female':
                gender = Icons.female;
                break;
              default:
                gender = MyFlutterApp.genderless;
                break;
            }
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 11,
                              offset: const Offset(0, 3),
                            )
                          ]),
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
                              child: Image.asset(
                                  "assets/images/document/logo.webp"),
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
                    const SizedBox(
                      height: 16,
                    ),
                    CustomCardProfileRow(
                      defaultKey: "Nombre",
                      defaultValue:
                          "${state.doctor.firstName} ${state.doctor.lastName}",
                      trailingIcon: Icons.account_circle,
                    ),
                    Divider(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.35),
                      height: 14,
                    ),
                    CustomCardProfileRow(
                      defaultKey: "Cedula",
                      defaultValue: state.doctor.dni.toString(),
                      trailingIcon: Icons.contact_emergency,
                    ),
                    Divider(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.35),
                      height: 14,
                    ),
                    CustomCardProfileRow(
                      defaultKey: "Cumpleaños",
                      defaultValue: state.doctor.birthday,
                      trailingIcon: Icons.calendar_month,
                    ),
                    Divider(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.35),
                      height: 14,
                    ),
                    CustomCardProfileRow(
                      defaultKey: "Genero",
                      defaultValue: genreTranslated,
                      trailingIcon: gender,
                    ),
                    Divider(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.35),
                      height: 14,
                    ),
                    CustomCardProfileRow(
                        defaultKey: "Especialidad",
                        defaultValue: "Doctor - ${state.doctor.speciality}",
                        trailingIcon: MyFlutterApp.user_md),
                    Divider(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.35),
                      height: 14,
                    ),
                    CustomCardProfileRow(
                      defaultKey: "ID Usuario",
                      defaultValue: state.doctor.id.toString(),
                      trailingIcon: Icons.verified_user,
                    ),
                  ],
                )));
          } else if (state is ProfileDataFail) {
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<ProfileDataCubit>()
                    .refreshProfile(user.userProfileId, authUser.accessToken);
              },
              child: Center(
                child: ListView(children: [
                  Container(
                    height: 225,
                    decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 11,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(children: [
                          CircleAvatar(
                            radius: 65.0,
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
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
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(18),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/not_found_logo.png",
                          ),
                          Text(
                            state.errorSMS,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Container(
                            // TODO MAKE A WIDGET
                            padding: EdgeInsets.only(top: size.height / 20),
                            width: size.width * 0.40,
                            height: size.height * 0.105,
                            child: MaterialButton(
                              color: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.0)),
                              elevation: 10,
                              focusColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              onPressed: () async {
                                await context
                                    .read<ProfileDataCubit>()
                                    .refreshProfile(user.userProfileId,
                                        authUser.accessToken);
                              },
                              child: Text('Reintentar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.color,
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.fontFamily,
                                      fontSize: 20)),
                            ),
                          )
                        ]),
                  )
                ]),
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
