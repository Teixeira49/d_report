import 'package:d_report/my_flutter_app_icons.dart';
import 'package:d_report/src/feature/profile_user/domain/entities/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/fields_constants.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../data/datasource/remote/profile_edit_remote_data_source.dart';
import '../../data/repositories/profile_edit_repository_impl.dart';
import '../cubit/profile_user_editor/profile_user_editor_cubit.dart';
import '../widgets/date_field.dart';
import '../widgets/dynamic_edit_field.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _dniController.dispose();
    _dateController.dispose();
    _genreController.dispose();
    _specialityController.dispose();
    super.dispose();
  }

  _updateData() {
    print('papaya');
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    //double sizeIcon = size.shortestSide * 0.50;
    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    User user = argument["userData"];
    Doctor doctor = argument["doctorData"];

    final size = MediaQuery.of(context).size;

    final formatKey = GlobalKey<FormState>();

    Future<void> selectDate(BuildContext context) async {
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
    }

    final profileEditSource = ProfileEditRemoteDataSourceImpl();
    final repository = ProfileEditRepositoryImpl(
        profileEditRemoteDataSource: profileEditSource);

    return BlocProvider(
      create: (_) => ProfileDataCubit(profileEditRepositoryImpl: repository),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              edit,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            shadowColor: Colors.transparent,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            automaticallyImplyLeading: true,
            elevation: 10,
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 225,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                floating: true,
                elevation: 10,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow.withOpacity(0.55),
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
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiaryContainer,
                                    child:
                                        Image.asset("assets/images/logo.png"),
                                  )),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 15,
                                    ),
                                    color: Theme.of(context).iconTheme.color,
                                    style:
                                        Theme.of(context).iconButtonTheme.style,
                                    onPressed: () {},
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        )
                      ],
                    ),
                    centerTitle: true,
                  ),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
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
                            defaultName: doctor.firstName,
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
                            defaultName: doctor.lastName,
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
                        defaultName: doctor.dni.toString(),
                        typeData: TextInputType.number,
                        contextRow: "Cedula",
                        iconData: Icons.contact_emergency,
                        controller: _dniController,
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                              child: DateTextField(
                            controllerData: _dateController,
                            selectedDate: DateTime.now(),
                          )),
                          const SizedBox(
                            width: 12,
                          ),
                          Flexible(
                            child: TypeGenreDropdownField(
                                controllerData: _genreController),
                          ),
                        ]),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      child: DataTextField(
                        defaultName: 'Bacteriologo',
                        typeData: TextInputType.text,
                        contextRow: 'Especialidad',
                        iconData: MyFlutterApp.user_md,
                        controller: _specialityController,
                      )),
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: FetchUpdateButton(
                      size: size, selected: 0, endEdit: () => _updateData()),
                )
              )
            ],
          )),
    );
  }
}
