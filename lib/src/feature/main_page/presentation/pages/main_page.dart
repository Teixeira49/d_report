import 'package:d_report/src/shared/domain/entities/auth_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:d_report/src/feature/main_page/domain/entities/patient.dart';
import 'package:flutter/material.dart';

import '../../../../shared/data/model/roles.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/drawer.dart';

import '../../data/datasources/remote/my_cases_remote_data_sources.dart';
import '../../data/repositories/my_cases_repository_impl.dart';
import '../cubit/my_cases/my_cases_cubit.dart';
import '../cubit/my_cases/my_cases_state.dart';
import '../widgets/case_tile_copy.dart';
import '../widgets/current_case.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MyMainPageState createState() => MyMainPageState();
}

class MyMainPageState extends State<MainPage> {
  int _currentPage = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
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

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = MyCasesRemoteDataSourceImpl();
    final repository =
        MyCasesRepositoryImpl(myCasesRemoteDataSource: remoteDataSource);

    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    final size = MediaQuery.of(context).size;

    //List<Patients> patients = [];
    List<Patient> regularP = [
      Patient(id: 1, name: "Jose", lastname: "Peres", age: 15, codHab: 'A-606'),
      Patient(id: 2, name: "Manu", lastname: "Peres", age: 15, codHab: 'A-606'),
      Patient(
          id: 3, name: "Miguel", lastname: "Peres", age: 15, codHab: 'A-606'),
      Patient(id: 4, name: "Leo", lastname: "Peres", age: 15, codHab: 'A-606'),
    ];
    List<Patient> currentP = [
      Patient(id: 5, name: "A", lastname: "Peres", age: 15, codHab: 'A-606'),
      Patient(id: 6, name: "B", lastname: "Peres", age: 15, codHab: 'A-606'),
      Patient(id: 7, name: "C", lastname: "Peres", age: 15, codHab: 'A-606'),
      Patient(id: 8, name: "D", lastname: "Peres", age: 15, codHab: 'A-606'),
    ];

    List<Widget> pages = [
      CurrentCasesPage(regularP),
      CurrentCasesPage(currentP)
    ];

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (_) => MyCasesCubit(repository)
        ..fetchCases(user.userProfileId, authUser.accessToken),
      child: Scaffold(
        key: scaffoldKey,

        appBar: AppBar(
          title: Row(
            children: [
              GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  child: user.userImgUrl == ""
                      ? Image.asset("assets/images/logo.png")
                      : Image.asset(user.userImgUrl), // TODO volver constante
                ),
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
              const SizedBox(width: 12),
              Text(UserRole.values[authUser.roleId].name),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    print('Se presionó el icono de búsqueda');
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          automaticallyImplyLeading: false,
        ),

        drawer: NavigatorDrawer(user: user, authUser: authUser),

        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.005, horizontal: size.width * 0.005),
          child: BlocBuilder<MyCasesCubit, MyCasesState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<MyCasesCubit>()
                      .refreshCases(user.userProfileId, authUser.accessToken);
                },
                child: _buildCasesList(state),
              );
            },
          ),
        ),
        // GestureDetector(
        //   child: pages[_currentPage],
        //   onHorizontalDragStart: (DragStartDetails details) {
        //     if (details.globalPosition.dx < 100) {
        //       scaffoldKey.currentState?.openDrawer();
        //     }
        //   },
        // ),

        floatingActionButton: Visibility(
          visible: ((_currentPage == 0) &&
              (authUser.roleId == UserRole.DOCTOR.index)),
          child: FloatingActionButton(
            backgroundColor:
                ThemeData().floatingActionButtonTheme.backgroundColor,
            child: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet<void>(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 110,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.010,
                              ),
                              child: ListTile(
                                title: Text('Crear Caso - Nuevo Paciente'),
                                dense: true,
                                tileColor: Colors.transparent,
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.of(context).pushNamed(
                                      '/main/new-case/new-patient',
                                      arguments: {
                                        "userData": user,
                                        "AuthCredentials": authUser,
                                      });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.010,
                              ),
                              child: ListTile(
                                title: Text('Crear Caso - Paciente Existente'),
                                dense: true,
                                tileColor: Colors.transparent,
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.of(context)
                                      .pushNamed('/main/new-case/find-patient');
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ),

        // Change a widget in other file
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          backgroundColor: ThemeData().bottomNavigationBarTheme.backgroundColor,
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
              label: 'Buscar Caso',
            ),
          ],
        ),

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  Widget _buildCasesList(MyCasesState state) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;

    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    if (state is MyCasesInitial) {
      return Center(
          child: CircularProgressIndicator(
        // TODO MAKE GLOBAL
        color: Theme.of(context).colorScheme.primary,
      ));
    } else if (state is MyCasesLoaded) {
      return GestureDetector(
        onVerticalDragDown: (DragDownDetails details) {
          if (details.globalPosition.dy < 50) {
            print("AAAA");
            context
                .read<MyCasesCubit>()
                .fetchCases(user.userProfileId, authUser.accessToken);
          }
        },
        child: ListView.builder(
            itemCount: state.cases.length,
            itemBuilder: (context, index) =>
                CaseTile(context, state.cases[index], authUser)),
      );
    } else if (state is MyCasesLoadedButEmpty) {
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
                  .read<MyCasesCubit>()
                  .fetchCases(user.userProfileId, authUser.accessToken);
            },
            child: const Text('Reintentar'),
          ),
        ],
      );
    } else if (state is MyCasesTimeout) {
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
                  .read<MyCasesCubit>()
                  .fetchCases(user.userProfileId, authUser.accessToken);
            },
            child: const Text('Reintentar'),
          ),
        ],
      );
    } else if (state is MyCasesFail) {
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
                  .read<MyCasesCubit>()
                  .fetchCases(user.userProfileId, authUser.accessToken);
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
