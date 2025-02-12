import 'package:d_report/src/shared/domain/entities/auth_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import '../../../../shared/data/model/roles.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/circular_progress_bar.dart';
import '../../../../shared/presentation/widget/drawer.dart';

import '../../data/datasources/remote/my_cases_remote_data_sources.dart';
import '../../data/repositories/my_cases_repository_impl.dart';
import '../cubit/my_cases/my_cases_cubit.dart';
import '../cubit/my_cases/my_cases_state.dart';
import '../widgets/bottom_bar_panel.dart';
import '../widgets/case_tile.dart';
import '../widgets/error_button.dart';
import '../widgets/floating_button_add_patient.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MyMainPageState createState() => MyMainPageState();
}

class MyMainPageState extends State<MainPage> {
  final int _currentPage = 0;
  bool _isSearching = false;

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
    if (_scrollController.position.pixels >=
        _scrollController
            .position.maxScrollExtent /*!context.read<MyCasesCubit>().si*/) {
      //context.read<MyCasesCubit>().fetchCases();
    }
  }

  void switchSearchState() {
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

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = MyCasesRemoteDataSourceImpl();
    final repository =
        MyCasesRepositoryImpl(myCasesRemoteDataSource: remoteDataSource);

    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    final size = MediaQuery.of(context).size;

    return BlocProvider(
        create: (_) => MyCasesCubit(repository)
          ..fetchCases(user.userProfileId, authUser.accessToken),
        child:
            BlocBuilder<MyCasesCubit, MyCasesState>(builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: _isSearching || _currentPage == 1
                  ? Container(
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
                      child: TextField(
                        controller: _searchController,
                        focusNode: _focusNode,
                        onChanged: (value) {
                          context.read<MyCasesCubit>().updateFilter(value);
                        },
                        onEditingComplete: () {},
                        autofocus: _currentPage == 1 ? false : true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          hintText: 'Buscar Paciente',
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              switchSearchState();
                              _searchController.clear();
                              context.read<MyCasesCubit>().updateFilter('');
                            },
                          ),
                          suffixIcon: Visibility(
                            visible: _searchController.text.isNotEmpty,
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
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        GestureDetector(
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.onSecondary,
                            child: user.userImgUrl == ""
                                ? Image.asset("assets/images/logo.png")
                                : Image.asset(
                                    user.userImgUrl), // TODO volver constante
                          ),
                          onTap: () {
                            scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                        const SizedBox(width: 15),
                        Text(UserRole.values[authUser.roleId].name)
                      ],
                    ),
              actions: [
                _isSearching
                    ? Container()
                    : IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          switchSearchState();
                        }),
              ],
            ),

            drawer: NavigatorDrawer(user: user, authUser: authUser),

            body: Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.005,
                    horizontal: size.width * 0.005),
                child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<MyCasesCubit>().refreshCases(
                          user.userProfileId, authUser.accessToken);
                    },
                    child: Center(
                      child: _buildCasesList(state, context, size),
                    )) //;
                //},
                //),
                ),
            // GestureDetector(
            //   child: pages[_currentPage],
            //   onHorizontalDragStart: (DragStartDetails details) {
            //     if (details.globalPosition.dx < 100) {
            //       scaffoldKey.currentState?.openDrawer();
            //     }
            //   },
            // ),

            floatingActionButton: FloatingActionButtonAddPatient(
              roleId: authUser.roleId,
              currentPage: _currentPage,
              isSearching: _isSearching,
              size: size,
              parseArguments: {
                "userData": user,
                "AuthCredentials": authUser,
              },
            ),

            bottomNavigationBar: BottomBarMainPanel(
              currentPage: _currentPage,
              parseArguments: {"userData": user, "AuthCredentials": authUser},
            ),

            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          );
        }));
  }

  Widget _buildCasesList(MyCasesState state, BuildContext context, Size size) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    if (state is MyCasesInitial || state is MyCasesLoading) {
      return const Center(
          child: CustomCircularProgressBar(
        labelText: 'Buscando Casos',
      ));
    } else if (state is MyCasesLoaded) {
      final filteredCases = state.cases
          .where((caseItem) => caseItem.patName
              .toLowerCase()
              .contains(state.filter.toLowerCase()))
          .toList();
      return GestureDetector(
        onVerticalDragDown: (DragDownDetails details) {
          if (details.globalPosition.dy < 50) {
            context
                .read<MyCasesCubit>()
                .fetchCases(user.userProfileId, authUser.accessToken);
          }
        },
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
            itemCount: filteredCases.length,
            itemBuilder: (context, index) =>
                CaseTile(context, filteredCases[index], authUser, user)),
      );
    } else if (state is MyCasesLoadedButEmpty) {
      return SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/not_found_logo.png",
            ),
            Text(
              state.sms,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            ErrorElevatedButton(
              size: size,
              function: () async {
                await context
                    .read<MyCasesCubit>()
                    .refreshCases(user.userProfileId, authUser.accessToken);
              },
            ),
            /*Container(
              // TODO MAKE A WIDGET
              padding: EdgeInsets.only(top: size.height / 20),
              width: size.width * 0.40,
              height: size.height * 0.105,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll<double>(7.5),
                  shadowColor: MaterialStatePropertyAll<Color>(
                      Theme.of(context).colorScheme.shadow),
                ),
                onPressed: () async {
                  await context
                      .read<MyCasesCubit>()
                      .refreshCases(user.userProfileId, authUser.accessToken);
                },
                child: Text('Reintentar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme.primary,
                        fontFamily: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.fontFamily,
                        fontSize: 20)),
              ),
            ),*/
          ],
        ),
      ));
    } else if (state is MyCasesTimeout) {
      return SingleChildScrollView(
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
                  /*ElevatedButton(
            onPressed: () async {
              await context
                  .read<MyCasesCubit>()
                  .refreshCases(user.userProfileId, authUser.accessToken);
            },
            child: const Text('Reintentar'),
          ),*/
                  ErrorElevatedButton(
                    size: size,
                    function: () async {
                      await context.read<MyCasesCubit>().refreshCases(
                          user.userProfileId, authUser.accessToken);
                    },
                  ),
                ],
              )));
    } else if (state is MyCasesFail) {
      return SingleChildScrollView(
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
                  /*ElevatedButton(
            onPressed: () async {
              await context
                  .read<MyCasesCubit>()
                  .fetchCases(user.userProfileId, authUser.accessToken);
            },
            child: const Text('Reintentar'),
          ),*/
                  ErrorElevatedButton(
                    size: size,
                    function: () async {
                      await context.read<MyCasesCubit>().refreshCases(
                          user.userProfileId, authUser.accessToken);
                    },
                  ),
                ],
              )));
    } else {
      return Container();
    }
  }
}
