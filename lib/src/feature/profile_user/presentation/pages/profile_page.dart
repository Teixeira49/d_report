import 'package:d_report/src/core/utils/constants/fields_constants.dart';
import 'package:d_report/src/feature/profile_user/data/datasource/remote/profile_remote_data_source.dart';
import 'package:d_report/src/feature/profile_user/data/repositories/profile_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

    final int profileId =
        (argument['docId'] != null) ? argument['docId'] : user.userProfileId;

    final bool isMyProfile = (argument['docId'] != null);

    DoctorProfile doctor = DoctorProfile(
        id: 1,
        firstName: "pepe",
        lastName: "Gonzales",
        dni: 123124,
        birthday: "25-10-1980",
        genre: "Male",
        range: "Doctor",
        speciality: "Bacteriologo",
        photoUrl: '',
        email: '',
        phone: '');

    return BlocProvider(
      create: (_) => ProfileDataCubit(profileRepositoryImpl: repository)
        ..getDoctorProfile(profileId, authUser.accessToken),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text("Perfil"),
          shadowColor: Colors.transparent,
          actions: [
            Visibility(
              visible: profileId == user.userProfileId,
              child: BlocBuilder<ProfileDataCubit, ProfileDataState>(
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
            ),
          ],
          leading: isMyProfile
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back))
              : null,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          automaticallyImplyLeading: !isMyProfile,
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
                            color: Theme.of(context)
                                .colorScheme
                                .shadow
                                .withOpacity(0.55),
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
                          'Buscando Usuario',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Correo del Usuario',
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
                      SizedBox(
                        height: size.height / 4,
                      ),
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .shadow
                                  .withOpacity(0.55),
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
                            '${Helper.capitalize(UserRole.values[authUser.roleId].name)}. ${Helper.capitalize(state.doctor.firstName)} ${Helper.capitalize(state.doctor.lastName)}',
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
                    Visibility(
                      visible: state.doctor.phone.isNotEmpty && state.doctor.phone != '',
                        child: CustomCardProfileRow(
                            defaultKey: "Telefono",
                            defaultValue: state.doctor.phone,
                            trailingIcon: Icons.phone_android),
                    ),
                    Visibility(
                        visible: state.doctor.phone.isNotEmpty && state.doctor.phone != '',
                        child: Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withOpacity(0.35),
                          height: 14,
                        ),
                    ),
                    CustomCardProfileRow(
                      defaultKey: "ID Usuario",
                      defaultValue:
                          '${((UserRole.values.firstWhere((element) => element.name == state.doctor.range)).name)[0]} - ${state.doctor.id.toString()}',
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
                            color: Theme.of(context)
                                .colorScheme
                                .shadow
                                .withOpacity(0.55),
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
                          '¡Usuario no Encontrado!',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Recargue la aplicacion',
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
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Ha ocurrido un problema',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ), // TODO MAKE CONSTANT
                          SizedBox(
                            height: 320,
                            child: Image.asset(
                              "assets/images/not_found_logo.png",
                            ),
                          ),
                          Text(
                            state.errorSMS,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Container(
                            // TODO MAKE A WIDGET
                            padding: EdgeInsets.only(top: size.height / 20),
                            width: size.width * 0.40,
                            height: size.height * 0.105,
                            child: MaterialButton(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.fontFamily,
                                      fontSize: 20)),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          )
                        ]),
                  ),
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
