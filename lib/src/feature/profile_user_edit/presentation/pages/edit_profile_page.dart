import 'package:d_report/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/fields_constants.dart';
import '../../../../shared/data/model/profile_model.dart';
import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/doctor.dart';
import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../../../../shared/presentation/widget/loading_show_dialog.dart';
import '../../data/datasource/remote/profile_edit_remote_data_source.dart';
import '../../data/repositories/profile_edit_repository_impl.dart';
import '../../domain/use_cases/compare_profile.dart';
import '../../domain/use_cases/create_instance_doctor_user.dart';
import '../../domain/use_cases/create_request_instance.dart';
import '../../domain/use_cases/post_profile_data.dart';
import '../cubit/profile_local_data/profile_local_data_cubit.dart';
import '../cubit/profile_local_data/profile_local_data_state.dart';
import '../cubit/profile_user_editor/profile_user_editor_cubit.dart';
import '../cubit/profile_user_editor/profile_user_editor_state.dart';
import '../widgets/date_field.dart';
import '../widgets/data_textfield.dart';
import '../../../../shared/presentation/widget/genre-user_field.dart';
import '../widgets/finish_edit_button.dart';

class EditProfilePage extends StatefulWidget {
  //final String namePatient;

  const EditProfilePage({super.key, required this.dataField});

  final String dataField;

  @override
  MyEditProfilePageState createState() => MyEditProfilePageState();
}

class MyEditProfilePageState extends State<EditProfilePage> {
  DateTime selectedDate = DateTime.now();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final ValueNotifier<String?> _genreController = ValueNotifier(null);
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isInit = true;

  @override
  void initState() {
    _isInit = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      dynamic args = ModalRoute.of(context)!.settings.arguments;
      DoctorProfile doctor = args["doctorData"];
      _dniController.text = doctor.dni.toString();
      if (doctor.firstName.isNotEmpty && doctor.firstName != '') {
        _nameController.text = doctor.firstName;
      }
      if (doctor.lastName.isNotEmpty && doctor.lastName != '') {
        _lastNameController.text = doctor.lastName;
      }
      if (doctor.genre.isNotEmpty && doctor.genre != '') {
        _genreController.value = doctor.genre;
      }
      if (doctor.speciality.isNotEmpty && doctor.speciality != '') {
        _specialityController.text = doctor.speciality;
      }
      if (doctor.birthday.isNotEmpty && doctor.birthday != '') {
        _dateController.text = doctor.birthday;
      }
      if (doctor.phone.isNotEmpty && doctor.phone != '') {
        _phoneController.text = doctor.phone;
      }
    }
    super.didChangeDependencies();
    _isInit = false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _dniController.dispose();
    _dateController.dispose();
    _genreController.dispose();
    _specialityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  DoctorProfile _updateData(int docId, String role, String email) {
    return DoctorProfileModel.fromEntity(DoctorProfile(
        id: docId,
        firstName: _nameController.text,
        lastName: _lastNameController.text,
        dni: int.parse(_dniController.text),
        genre: _genreController.value ?? '',
        birthday: _dateController.text,
        range: role,
        speciality: _specialityController.text,
        photoUrl: '',
        email: email,
        phone: _phoneController.text));
  }

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    AuthUser authUser = argument["AuthCredentials"];
    DoctorProfile doctor = argument["doctorData"];

    final size = MediaQuery.of(context).size;

    /*Future<void> selectDate(
      BuildContext context,
    ) async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now());

      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          _dateController.text = selectedDate.toString().split(" ")[0];
        });
      }
    }*/

    final profileEditSource = ProfileEditRemoteDataSourceImpl();
    final repository = ProfileEditRepositoryImpl(
        profileEditRemoteDataSource: profileEditSource);

    final CreateInstanceDoctorUserUseCase createInstanceDoctorUserUseCase =
        CreateInstanceDoctorUserUseCase();
    final CompareProfilesUseCase compareProfilesUseCase =
        CompareProfilesUseCase();
    final CreateInstanceProfileUserRequestUseCase
        createInstanceProfileUserRequestUseCase =
        CreateInstanceProfileUserRequestUseCase();
    final PostProfileDataUseCase postProfileDataUseCase =
        PostProfileDataUseCase(repository);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ProfileDataCubit(
                compareProfilesUseCase,
                postProfileDataUseCase,
                createInstanceProfileUserRequestUseCase),
          ),
          BlocProvider(
            create: (_) =>
                ProfileLocalDataCubit(createInstanceDoctorUserUseCase)
                  ..onModifySelection(doctor.range,
                      DoctorProfileModel.fromEntity(doctor).toJson()),
          )
        ],
        child: BlocBuilder<ProfileLocalDataCubit, ProfileLocalDataState>(
            builder: (contextFather, stateFather) {
          return BlocConsumer<ProfileDataCubit, ProfileUserEditState>(
            listener: (context, state) {
              if (state is ProfileUserEditLoading) {
                LoadingShowDialog.show(context, 'Actualizando Informacion');
              }
              if (state is ProfileUserEditFail) {
                Navigator.of(context).pop(true);
                Future.delayed(const Duration(milliseconds: 100), () {
                  FloatingWarningSnackBar.show(context, state.errorSMS);
                });
              }
              if (state is ProfileUserEditTimeout) {
                Navigator.of(context).pop(true);
                Future.delayed(const Duration(milliseconds: 100), () {
                  FloatingWarningSnackBar.show(context, state.sms);
                });
              }
              if (state is ProfileUserEditWithoutUpdate) {
                Navigator.of(context).pop(true);
                Future.delayed(const Duration(milliseconds: 100), () {
                  FloatingWarningSnackBar.show(context, state.sms);
                });
              }
              if (state is ProfileUserEditPosted) {
                Navigator.of(context).pop(true);
                Future.delayed(const Duration(milliseconds: 100), () {
                  FloatingSnackBar.show(
                      context,
                      'Informe guardado con exito.',
                      Icons.check,
                      Colors.green); // TODO Safe color in styles folder
                });
                dynamic doctorEditRequest =
                    DoctorProfileModel.fromEntity(state.doctor).toJson();
                contextFather
                    .read<ProfileLocalDataCubit>()
                    .setOriginalDoctor(doctorEditRequest);
              }
            },
            builder: (context, state) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      edit,
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                    shadowColor: Colors.transparent,
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                    automaticallyImplyLeading: true,
                    elevation: 10,
                  ),
                  body: CustomScrollView(
                    shrinkWrap: true,
                    //physics: const NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 225,
                        backgroundColor:
                            Theme.of(context).appBarTheme.backgroundColor,
                        floating: true,
                        elevation: 10,
                        flexibleSpace: Container(
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
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
                          child: FlexibleSpaceBar(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      child: SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Container(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onTertiaryContainer,
                                              child: Image.asset(
                                                  "assets/images/logo.png"),
                                            )),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              size: 15,
                                            ),
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            style: Theme.of(context)
                                                .iconButtonTheme
                                                .style,
                                            onPressed: () {},
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            centerTitle: true,
                          ),
                        ),
                        centerTitle: true,
                        automaticallyImplyLeading: false,
                      ),
                      SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: DataTextField(
                                          typeData: TextInputType.name,
                                          contextRow: "Nombre",
                                          iconData: Icons.person,
                                          controller: _nameController,
                                        )),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Flexible(
                                            child: DataTextField(
                                          typeData: TextInputType.name,
                                          contextRow: "Apellido",
                                          iconData: Icons.person,
                                          controller: _lastNameController,
                                        )),
                                      ],
                                    )),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    child: DataTextField(
                                      typeData: TextInputType.number,
                                      contextRow: "Cedula",
                                      iconData: Icons.contact_emergency,
                                      controller: _dniController,
                                    )),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                            child: DateTextField(
                                          controllerData: _dateController,
                                          selectedDate:
                                              DateTime.parse(doctor.birthday),
                                        )),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Flexible(
                                          child: TypeGenreDropdownField(
                                            controllerData: _genreController,
                                            defaultValue: doctor.genre,
                                          ),
                                        ),
                                      ]),
                                ),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    child: DataTextField(
                                      //defaultName: doctor.speciality,
                                      typeData: TextInputType.text,
                                      contextRow: 'Especialidad',
                                      iconData: MyFlutterApp.user_md,
                                      controller: _specialityController,
                                    )),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    child: DataTextField(
                                      typeData: TextInputType.phone,
                                      contextRow: "Telefono",
                                      iconData: Icons.phone_android,
                                      controller: _phoneController,
                                    )),
                                FetchUpdateButton(
                                    size: size,
                                    selected: 0,
                                    endEdit: () => context
                                        .read<ProfileDataCubit>()
                                        .putDoctorProfile(
                                            stateFather.getLocalDoc()!,
                                            _updateData(doctor.id, doctor.range,
                                                doctor.email),
                                            authUser.accessToken)),
                              ],
                            ),
                          ))
                    ],
                  ));
            },
          );
        }));
  }
}
