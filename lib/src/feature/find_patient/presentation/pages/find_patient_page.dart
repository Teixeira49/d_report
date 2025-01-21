import 'package:d_report/src/feature/find_patient/data/datasource/remote/find_patient_remote_datasource.dart';
import 'package:d_report/src/feature/find_patient/domain/entities/patient.dart';
import 'package:d_report/src/shared/presentation/widget/circular_progress_bar.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/data/model/search_key.dart';
import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../../data/repository/find_patient_repository_impl.dart';
import '../cubit/search_patient/search_patient_cubit.dart';
import '../cubit/search_patient/search_patient_state.dart';
import '../widgets/case_tile_copy.dart';
import '../widgets/next_state_button.dart';
import '../widgets/select_filter_button.dart';

class FindPatientPage extends StatefulWidget {
  const FindPatientPage({super.key});

  @override
  MyFindPatientPageState createState() => MyFindPatientPageState();
}

class MyFindPatientPageState extends State<FindPatientPage> {
  bool _isSearching = false;
  TextInputType _inputSearchType = TextInputType.text;
  int _selectedIndex = SearchKeys.DEFAULT.index;

  int _tempIndexSelectedPatient = -1;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _switchSearchState() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        Future.delayed(const Duration(milliseconds: 100), () {
          // TODO Make Constant file
          _focusNode.requestFocus();
        });
      } else {
        _searchController.clear();
        _focusNode.unfocus();
      }
    });
  }

  void _onButtonPressed(int index) {
    setState(() {
      if (_selectedIndex != index) {
        _searchController.clear();
        _focusNode.unfocus();
        _selectedIndex = index;
        if (index == SearchKeys.DNI.index ||
            index == SearchKeys.GUARDIAN_DNI.index) {
          _inputSearchType = TextInputType.number;
        } else {
          _inputSearchType = TextInputType.text;
        }
        Future.delayed(const Duration(milliseconds: 100), () {
          // TODO Make Constant file
          _focusNode.requestFocus();
        });
      } else {
        _focusNode.unfocus();
        _selectedIndex = SearchKeys.DEFAULT.index;
        _inputSearchType = TextInputType.text;
        Future.delayed(const Duration(milliseconds: 100), () {
          // TODO Make Constant file
          _focusNode.requestFocus();
        });
      }
    });
    if (!_isSearching) {
      Future.delayed(const Duration(milliseconds: 280), () {
        // TODO MAKE CONSTANT
        _switchSearchState();
      });
    }
  }

  List<SearchPatient> filteredCases = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyboardEnabled = MediaQuery.of(context).viewInsets.bottom;

    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    final findPatientCaseDataSource = FindPatientRemoteDataSourceImpl();
    final repository = FindPatientRepositoryImpl(
        findPatientRemoteDataSource: findPatientCaseDataSource);

    void finisherSearch() {
      Map<String, dynamic> x = {
        'patName': filteredCases[_tempIndexSelectedPatient].patName,
        'patLastName':
        filteredCases[_tempIndexSelectedPatient].patLastName,
        'patDni': filteredCases[_tempIndexSelectedPatient].patDni,
        'patGender': filteredCases[_tempIndexSelectedPatient].patGender,
        'patBirthdayDate':
        filteredCases[_tempIndexSelectedPatient].patBirthdayDate,
        'patBirthdayPlace':
        filteredCases[_tempIndexSelectedPatient].patBirthdayPlace,
        'patGuardianDni':
        filteredCases[_tempIndexSelectedPatient].patGuardianDni,
        'patBloodType':
        filteredCases[_tempIndexSelectedPatient].patBloodType,
      };

      Navigator.of(context)
          .pushNamed('/main/new-case/add-case', arguments: {
        "userData": user,
        "AuthCredentials": authUser,
        "patient": x,
      });
    }
    return BlocProvider(
        create: (_) => FindPatientCubit(repository),
        child: BlocConsumer<FindPatientCubit, FindPatientState>(
            listener: (context, state) {
          if (state is FindPatientFail) {
            FloatingWarningSnackBar.show(context, state.errorSMS);
          } else if (state is FindPatientTimeout) {
            FloatingWarningSnackBar.show(context, state.errorSMS);
          }
        }, builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: _isSearching
                    ? Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).listTileTheme.tileColor,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.shadow.withOpacity(0.55),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _searchController,
                          focusNode: _focusNode,
                          keyboardType: _inputSearchType,
                          onChanged: (value) {
                            _tempIndexSelectedPatient = -1;
                            context.read<FindPatientCubit>().findPatients(
                                _searchController.text,
                                _selectedIndex,
                                authUser.accessToken); //_selectedIndex
                          },
                          onEditingComplete: () {},
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            hintText: 'Buscar Paciente',
                            //prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                            suffixIcon: Visibility(
                              visible: _searchController.text.isNotEmpty, // TODO MAKE GLOBAL
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                  });
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                            prefixIcon: IconButton(
                              onPressed: () {
                                _switchSearchState();
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      )
                    : Text(
                        registerData + space + patient,
                        style: Theme.of(context).appBarTheme.titleTextStyle,
                      ),
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                automaticallyImplyLeading: !_isSearching,
                actions: !_isSearching
                    ? [
                        IconButton(
                            onPressed: () {
                              _switchSearchState();
                            },
                            icon: const Icon(Icons.search)),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                  '/main/new-case/new-patient',
                                  arguments: {
                                    "userData": user,
                                    "AuthCredentials": authUser,
                                  });
                            },
                            icon: const Icon(Icons.cached)),
                      ]
                    : [],
              ),
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.010,
                      vertical: size.height * 0.024,
                    ),
                    child: Text(
                      "Buscar paciente ya registrado",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.075,
                      vertical: size.height * 0.010,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomSelectButton(
                          index: SearchKeys.DNI.index,
                          name: 'Cedula Paciente',
                          selectIndex: _selectedIndex,
                          onPressed: () =>
                              _onButtonPressed(SearchKeys.DNI.index),
                        ),
                        CustomSelectButton(
                          index: SearchKeys.GUARDIAN_DNI.index,
                          name: 'Cedula Reptt.',
                          selectIndex: _selectedIndex,
                          onPressed: () =>
                              _onButtonPressed(SearchKeys.GUARDIAN_DNI.index),
                        ),
                        CustomSelectButton(
                          index: SearchKeys.FULL_NAME.index,
                          name: 'Nombre Paciente',
                          selectIndex: _selectedIndex,
                          onPressed: () =>
                              _onButtonPressed(SearchKeys.FULL_NAME.index),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                      vertical: size.height * 0.010,
                    ),
                    child: Text(
                      "Seleccione la clave de busqueda que usara para encontrar su paciente.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Expanded(child: _buildSearchedPatients(state)),
                  Visibility(
                      visible: keyboardEnabled == 0,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: NextStateButton(
                                size: size,
                                selected: _tempIndexSelectedPatient,
                                endFindPatient: finisherSearch,),
                          )))
                ],
              ));
        }));
  }

  Widget _buildSearchedPatients(FindPatientState state) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    final size = MediaQuery.of(context).size;

    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    if (state is FindPatientInitial) {
      return Container(); //Center(
      //    child: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // children: [Image.asset('assets/images/register/profile.png')],
      //));
    } else if (state is FindPatientLoading) {
      return const Center(
        child: CustomCircularProgressBar(),
      );
    } else if (state is FindPatientLoaded) {
      filteredCases = (state.patients
          .where((caseItem) => caseItem.patName
              .toLowerCase()
              .contains(state.filter.toLowerCase()))
          .toList());

      return GestureDetector(
        onVerticalDragDown: (DragDownDetails details) {
          if (details.globalPosition.dy < 50) {
            context.read<FindPatientCubit>().findPatients(
                _searchController.text, _selectedIndex, authUser.accessToken);
          }
        },
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: filteredCases.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (_tempIndexSelectedPatient == index) {
                    setState(() {
                      filteredCases[index].patIsSelected = false;
                      _tempIndexSelectedPatient = -1;
                    });
                  } else {
                    setState(() {
                      filteredCases.forEach((pat) => pat.patIsSelected = false);
                      filteredCases[index].patIsSelected = true;
                      _tempIndexSelectedPatient = index;
                    });
                  }
                },
                child: CaseTile(context, filteredCases[index], authUser, user),
              );
            }),
      );
    } else if (state is FindPatientLoadedButEmpty) {
      return Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/images/not_found_logo.png'),
            ),
            const Text('Paciente no encontrado'),
          ],
        ),
      ));
    } else if (state is FindPatientTimeout) {
      return Center(
          child: SingleChildScrollView(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset('assets/images/not_found_logo.png'),
          ),
          Text(state.errorSMS),
        ],
      )));
    } else if (state is FindPatientFail) {
      return Center(
          child: SingleChildScrollView(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset('assets/images/not_found_logo.png'),
          ),
          Text(state.errorSMS),
        ],
      )));
    } else {
      return Container();
    }
  }
}
