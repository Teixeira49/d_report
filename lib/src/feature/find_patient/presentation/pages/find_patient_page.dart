import 'package:d_report/src/feature/find_patient/data/datasource/remote/find_patient_remote_datasource.dart';
import 'package:d_report/src/shared/presentation/widget/circular_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
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
  int _selectedIndex = -1;

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
      _searchController.clear();
      _selectedIndex = index;
      if (index == 1 || index == 2) {
        _inputSearchType = TextInputType.number;
      } else {
        _inputSearchType = TextInputType.text;
      }
    });
    if (!_isSearching) {
      Future.delayed(const Duration(milliseconds: 280), () {
        _switchSearchState();
      });
    }
  }

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

    return BlocProvider(
        create: (_) => FindPatientCubit(repository),
        child: BlocConsumer<FindPatientCubit, FindPatientState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                  appBar: AppBar(
                    title: _isSearching
                        ? Container(
                            padding: const EdgeInsets.only(right: 12),
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).listTileTheme.tileColor,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
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
                                context.read<FindPatientCubit>().findPatients(
                                    _searchController.text,
                                    9,
                                    authUser.accessToken); //_selectedIndex
                              },
                              onEditingComplete: () {},
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                hintText: 'Buscar Paciente',
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
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                    leading: IconButton(
                      icon: !_isSearching
                          ? const Icon(Icons.close)
                          : const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (_isSearching) {
                          _switchSearchState();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    actions: [
                      !_isSearching
                          ? IconButton(
                              onPressed: () {
                                _switchSearchState();
                              },
                              icon: const Icon(Icons.search))
                          : Container()
                    ],
                  ),
                  body: Column(
                    //alignment: Alignment.topCenter,
                    children: [
                      //SingleChildScrollView(
                      //child: //Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      //mainAxisSize: MainAxisSize.max,
                      //children: [
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
                              index: 1,
                              name: 'Cedula Paciente',
                              selectIndex: _selectedIndex,
                              onPressed: () => _onButtonPressed(1),
                            ),
                            CustomSelectButton(
                              index: 2,
                              name: 'Cedula Reptt.',
                              selectIndex: _selectedIndex,
                              onPressed: () => _onButtonPressed(2),
                            ),
                            CustomSelectButton(
                              index: 3,
                              name: 'Nombre Paciente',
                              selectIndex: _selectedIndex,
                              onPressed: () => _onButtonPressed(3),
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
                      //],
                      //),
                      //),
                      /*Center(
                        child: SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: size.height * 0.25,
                            ),
                            child: IntrinsicHeight(
                              child: ListView(),
                              ),
                            ),
                          ),
                        ),*/
                      Visibility(
                          visible: keyboardEnabled == 0,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child:
                                    NextStateButton(size: size, selected: _tempIndexSelectedPatient),
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
      var filteredCases = state.patients
          .where((caseItem) => caseItem.patName
              .toLowerCase()
              .contains(state.filter.toLowerCase()))
          .toList();
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
    } else if (state is FindPatientTimeout || state is FindPatientFail) {
      return Center(
          child: SingleChildScrollView(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset('assets/images/not_found_logo.png'),
          ),
          const Text('Error en el Sistema'),
        ],
      )));
    } else {
      return Container();
    }
  }
}
