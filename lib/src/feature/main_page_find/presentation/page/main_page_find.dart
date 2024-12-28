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
import '../widget/case_tile_copy.dart';

class MainPageFind extends StatefulWidget {
  const MainPageFind({super.key});

  @override
  MyMainPageFindState createState() => MyMainPageFindState();
}

class MyMainPageFindState extends State<MainPageFind> {
  int _currentPage = 1;
  bool _isSearching = false;
  int _selectedIndex = SearchKeys.DEFAULT.index;

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
    print('pepe');
    if (_scrollController.position.pixels >=
        _scrollController
            .position.maxScrollExtent /*!context.read<MyCasesCubit>().si*/) {
      //context.read<MyCasesCubit>().fetchCases();
      print("Scroll");
    }
  }

  void switchSearchState() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        Future.delayed(Duration(milliseconds: 100), () {
          _focusNode.requestFocus();
        });
      } else {
        _searchController.clear();
        _focusNode.unfocus();
      }
    });
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

    return BlocProvider(
        create: (_) => FindCasesCubit(repository),
        child: BlocBuilder<FindCasesCubit, FindCasesState>(
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
                      color: Colors.grey.withOpacity(0.5),
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
                    context.read<FindCasesCubit>().fetchSearchCases(_searchController.text, _selectedIndex, authUser.accessToken);
                  },
                  onEditingComplete: () {},
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    hintText: 'Buscar Paciente',
                    prefixIcon: IconButton(
                      icon: Icon(
                          Icons.clear,
                          color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        _searchController.clear();
                      },
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
            body: Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.005,
                    horizontal: size.width * 0.005),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            child: TextButton(
                          onPressed: () {},
                          child: Text('Nombre'),
                        )),
                        Container(
                            child: TextButton(
                          onPressed: () {},
                          child: Text('Cedula'),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            child: TextButton(
                          onPressed: () {},
                          child: Text('Diagnostico'),
                        )),
                        Container(
                            child: TextButton(
                          onPressed: () {},
                          child: Text('Entrada'),
                        )),
                        Container(
                            child: TextButton(
                          onPressed: () {},
                          child: Text('Final'),
                        )),
                        Container(
                            child: TextButton(
                          onPressed: () {},
                          child: Text('Status'),
                        )),
                      ],
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<FindCasesCubit>()
                            .refreshCases(
                            _searchController.text, _selectedIndex, authUser.accessToken);
                      },
                      child: _buildCasesList(state, context),
                    )
                  ],
                )
                //return
                ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                if (index != _currentPage) {
                  switch (index) {
                    case 1:
                      Navigator.of(context).pushReplacementNamed(
                          '/main/patients/find/',
                          arguments: {
                            "userData": user,
                            "AuthCredentials": authUser
                          });
                      break;
                    case 0:
                      Navigator.of(context).pushReplacementNamed(
                          '/main/patients/',
                          arguments: {
                            "userData": user,
                            "AuthCredentials": authUser
                          });
                      break;
                  }
                }
              },
              backgroundColor:
                  ThemeData().bottomNavigationBarTheme.backgroundColor,
              selectedItemColor:
                  ThemeData().bottomNavigationBarTheme.selectedItemColor,
              selectedLabelStyle:
                  ThemeData().bottomNavigationBarTheme.selectedLabelStyle,
              currentIndex: _currentPage,
              items: [
                /*BottomNavigationBarItem(
              icon: Icon(
                  Icons.stacked_bar_chart_rounded
              ),
              label: 'Statistics',
            ),*/
                BottomNavigationBarItem(
                  icon: _currentPage == 1
                      ? const Icon(Icons.other_houses_outlined)
                      : const Icon(Icons.other_houses),
                  label: 'Mis Casos',
                ),
                BottomNavigationBarItem(
                  icon: _currentPage == 1
                      ? const Icon(Icons.folder_copy)
                      : const Icon(Icons.folder_copy_outlined),
                  label: 'Buscar Expediente',
                ),
              ],
            ),
          );
        }));
  }

  Widget _buildCasesList(FindCasesState state, BuildContext context) { // TODO RENAME
    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    if (state is FindCasesInitial) {
      return Center(child: Container(child: Text("Ingrese una opcion para buscar"),));
    } else if (state is FindCasesLoading) {
      return const Center(child: CustomCircularProgressBar());
    } else if (state is FindCasesLoaded) {
      final filteredCases = state.cases
          .where((caseItem) => caseItem.patName
          .toLowerCase()
          .contains(state.filter.toLowerCase()))
          .toList();
      return GestureDetector(
        onVerticalDragDown: (DragDownDetails details) {
          if (details.globalPosition.dy < 50) {
            context
                .read<FindCasesCubit>()
                .fetchSearchCases(_searchController.text, _selectedIndex, authUser.accessToken);
          }
        },
        child: ListView.builder(
            itemCount: filteredCases.length,
            itemBuilder: (context, index) =>
                CaseTile(context, filteredCases[index], authUser, user)),
      );
    } else if (state is FindCasesLoadedButEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/not_found_logo.png",
          ),
          Text(state.sms),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await context
                  .read<FindCasesCubit>()
                  .refreshCases(_searchController.text, _selectedIndex, authUser.accessToken);
            },
            child: const Text('Reintentar'),
          ),
        ],
      );
    } else if (state is FindCasesTimeout) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/not_found_logo.png",
          ),
          //Text(state.sms),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await context
                  .read<FindCasesCubit>()
                  .refreshCases(_searchController.text, _selectedIndex, authUser.accessToken);
            },
            child: const Text('Reintentar'),
          ),
        ],
      );
    } else if (state is FindCasesFail) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/not_found_logo.png",
          ),
          Text(
            state.errorSMS,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await context
                  .read<FindCasesCubit>()
                  .fetchSearchCases(_searchController.text, _selectedIndex, authUser.accessToken);
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
