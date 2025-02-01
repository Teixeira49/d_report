import 'package:d_report/src/feature/main_page_find/domain/entities/search_filter.dart';
import 'package:d_report/src/feature/main_page_find/presentation/widget/select_filter_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/data/model/search_key.dart';
import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/circular_progress_bar.dart';
import '../../../../shared/presentation/widget/drawer.dart';
import '../../data/datasources/my_cases_remote_data_sources.dart';
import '../../data/repositories/my_cases_repository_impl.dart';
import '../cubit/find_case/find_cases_cubit.dart';
import '../cubit/find_case/find_cases_state.dart';
import '../widget/bottom_bar_panel.dart';
import '../widget/case_tile_copy.dart';
import '../widget/error_button.dart';
import '../widget/filter_search_window.dart';

class MainPageFind extends StatefulWidget {
  const MainPageFind({super.key});

  @override
  MyMainPageFindState createState() => MyMainPageFindState();
}

class MyMainPageFindState extends State<MainPageFind> {
  final int _currentPage = 1;
  bool _isSearching = false;
  int _selectedIndex = SearchKeys.DEFAULT.index;
  final SearchFilter _searchFilter = SearchFilter();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onScroll() {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    AuthUser authUser = argument["AuthCredentials"];
    if (_scrollController.position.pixels >=
        _scrollController
            .position.maxScrollExtent) {
      setState(() {
        context.read<FindCasesCubit>().fetchSearchCases(
            _searchController.text,
            _selectedIndex,
            authUser.accessToken, false);
        /*
        final remoteDataSource = FindCasesRemoteDataSourceImpl();
        final repository =
        FindCasesRepositoryImpl(myCasesRemoteDataSource: remoteDataSource);
        FindCasesCubit(repository);

        BlocProvider.of<FindCasesCubit>(context).fetchSearchCases(
            _searchController.text,
            _selectedIndex,
            authUser.accessToken, false);*/
      });
    }
  }

  void _switchSearchState() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        Future.delayed(Duration(milliseconds: 100), () {
          // TODO MAKE CONSTANT
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
        /*if (index == SearchKeys.DNI.index ||
            index == SearchKeys.GUARDIAN_DNI.index) {
          _inputSearchType = TextInputType.number;
        } else {
          _inputSearchType = TextInputType.text;
        }*/
        Future.delayed(const Duration(milliseconds: 100), () {
          // TODO Make Constant file
          _focusNode.requestFocus();
        });
      } else {
        _focusNode.unfocus();
        _selectedIndex = SearchKeys.DEFAULT.index;
        //_inputSearchType = TextInputType.text;
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

  void _isMoreParameters(int index) {
    _selectedIndex = SearchKeys.DEFAULT.index;
    searchFilterWindow(context, _searchFilter);
  }

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = FindCasesRemoteDataSourceImpl();
    final repository =
        FindCasesRepositoryImpl(myCasesRemoteDataSource: remoteDataSource);

    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    final size = MediaQuery.of(context).size;

    return BlocBuilder<FindCasesCubit, FindCasesState>(
            //buildWhen: (previous, current) {
            //  return current is FindCasesLoading;
            //},
            builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Container(
                padding: const EdgeInsets.only(right: 12),
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).listTileTheme.tileColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .shadow
                          .withOpacity(0.55),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: //ListTile(),
                    TextFormField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  onChanged: (value) {
                    context.read<FindCasesCubit>().fetchSearchCases(
                        _searchController.text,
                        _selectedIndex,
                        authUser.accessToken);
                  },
                  onEditingComplete: () {},
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    hintText: 'Buscar Paciente',
                    prefixIcon: Visibility(
                      visible: _searchController.text.isNotEmpty,
                      // TODO MAKE GLOBAL
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                          });
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    //focusedBorder: UnderlineInputBorder(
                    //    borderSide: BorderSide(color: Colors.white)),
                    //enabledBorder: UnderlineInputBorder(
                    //    borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
            ),
            drawer: NavigatorDrawer(user: user, authUser: authUser),
            body: Center(
              child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 14, horizontal: size.width * 0.005),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        child: Wrap(
                        children: [
                          CustomSelectButton(
                            index: SearchKeys.FULL_NAME.index,
                            name: 'Nombre',
                            selectIndex: _selectedIndex,
                            onPressed: _onButtonPressed,
                          ),
                          CustomSelectButton(
                            index: SearchKeys.ANY_DNI.index,
                            name: 'Cedula',
                            selectIndex: _selectedIndex,
                            onPressed: _onButtonPressed,
                          ),
                          CustomSelectButton(
                            index: SearchKeys.DIAGNOSIS.index,
                            name: 'Diagnostico',
                            selectIndex: _selectedIndex,
                            onPressed: _onButtonPressed,
                          ),
                          CustomSelectButton(
                            index: SearchKeys.SYMPTOMATOLOGY.index,
                            name: 'Sintomas',
                            selectIndex: _selectedIndex,
                            onPressed: _onButtonPressed,
                          ),
                          CustomSelectButton(
                            index: SearchKeys.ROOM.index,
                            name: 'Habitacion',
                            selectIndex: _selectedIndex,
                            onPressed: _onButtonPressed,
                          ),
                          CustomSelectButton(
                            index: SearchKeys.BLOOD_TYPE.index,
                            name: 'Tipo de Sangre',
                            selectIndex: _selectedIndex,
                            onPressed: _onButtonPressed,
                          ),
                          CustomSelectButton(
                            index: -1,
                            name: 'Mas',
                            selectIndex: _selectedIndex,
                            onPressed: _isMoreParameters,
                          ),
                        ],
                      ),),
                      Flexible(
                          child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<FindCasesCubit>().refreshCases(
                              _searchController.text,
                              _selectedIndex,
                              authUser.accessToken);
                        },
                        child: _buildCasesList(state, context),
                      ))
                    ],
                  )
                  //return
                  ),
            ),
            bottomNavigationBar: BottomBarMainPanel(
              currentPage: _currentPage,
              parseArguments: {"userData": user, "AuthCredentials": authUser},
            ),
          );
        });
  }

  Widget _buildCasesList(FindCasesState state, BuildContext context) {
    // TODO RENAME
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    final themeColor = MediaQuery.of(context).platformBrightness.index;
    final size = MediaQuery.of(context).size;

    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    if (state is FindCasesInitial) {
      return Center(
          child: SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.all(24),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(themeColor == 0
                            ? 'assets/images/folder_search/folder_dark.png'
                            : 'assets/images/folder_search/folder_light.png'),
                        Text(
                          "Elija un filtro o escriba para empezar a buscar",
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ]))));
    } else if (state is FindCasesLoading) {
      return const Center(child: CustomCircularProgressBar());
    } else if (state is FindCasesLoaded) {
      final filteredCases = state.cases
          .where((caseItem) => caseItem.patName
              .toLowerCase()
              .contains(state.filter.toLowerCase()))
          .toList();
      return SafeArea(
        minimum: const EdgeInsets.only(top: 6, left: 12, right: 12),
          child: GestureDetector(
        onVerticalDragDown: (DragDownDetails details) {
          if (details.globalPosition.dy < 50) {
            context.read<FindCasesCubit>().fetchSearchCases(
                _searchController.text, _selectedIndex, authUser.accessToken);
          }
        },
        child: Card(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: Scrollbar(
            controller: _scrollController,
              radius: const Radius.circular(45),
              child: ListView.builder(
            controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
              itemCount: filteredCases.length,
            itemBuilder: (context, index) =>
                CaseTile(context, filteredCases[index], authUser, user))),
      )));
    } else if (state is FindCasesLoadedButEmpty) {
      return Center(
          child: SingleChildScrollView(
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
                      /*
          ElevatedButton(
            onPressed: () async {
              await context.read<FindCasesCubit>().refreshCases(
                  _searchController.text, _selectedIndex, authUser.accessToken);
            },
            child: const Text('Reintentar'),
          ),*/
                      ErrorElevatedButton(
                        size: size,
                        function: () async {
                          await context.read<FindCasesCubit>().refreshCases(
                              _searchController.text,
                              _selectedIndex,
                              authUser.accessToken);
                        },
                      ),
                    ],
                  ))));
    } else if (state is FindCasesTimeout) {
      return Center(
          child: SingleChildScrollView(
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
                        'El servidor ha tardado mucho en responder',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      ErrorElevatedButton(
                        size: size,
                        function: () async {
                          await context.read<FindCasesCubit>().refreshCases(
                              _searchController.text,
                              _selectedIndex,
                              authUser.accessToken);
                        },
                      ),
                      /*ElevatedButton(
            onPressed: () async {
              await context.read<FindCasesCubit>().refreshCases(
                  _searchController.text, _selectedIndex, authUser.accessToken);
            },
            child: const Text('Reintentar'),
          ),*/
                    ],
                  ))));
    } else if (state is FindCasesFail) {
      return Center(
          child: SingleChildScrollView(
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
            ErrorElevatedButton(
              size: size,
              function: () async {
                await context.read<FindCasesCubit>().refreshCases(
                    _searchController.text,
                    _selectedIndex,
                    authUser.accessToken);
              },
            ),
            /*ElevatedButton(
            onPressed: () async {
              await context.read<FindCasesCubit>().fetchSearchCases(
                  _searchController.text, _selectedIndex, authUser.accessToken);
            },
            child: const Text('Reintentar'),
          ),*/
          ],
        ),
      )));
    } else {
      return Container();
    }
  }
}
