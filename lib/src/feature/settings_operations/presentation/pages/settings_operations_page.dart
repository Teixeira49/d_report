import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/presentation/cubit/theme_cubit.dart';
import '../widgets/theme_selector.dart';

class SettingsOperationsPage extends StatefulWidget {
  const SettingsOperationsPage({super.key});

  @override
  MySettingOperationsState createState() => MySettingOperationsState();
}

class MySettingOperationsState extends State<SettingsOperationsPage> {
  late final int initialPage;
  late final themeC;

  late final PageController _pageController;

  bool _isInit = true;

  @override
  void initState() {
    _isInit = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final prefs = SharedPreferences.getInstance();
      dynamic args = ModalRoute.of(context)!.settings.arguments;
      initialPage = (args['id'] != null) ? args['id'] : 1;
      _pageController = PageController(initialPage: initialPage);
    }
    super.didChangeDependencies();
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyboardEnabled = MediaQuery.of(context).viewInsets.bottom;

    dynamic arguments = ModalRoute.of(context)!.settings.arguments;

    //Map<String, dynamic> patient = arguments['patKey'];

    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ThemeCubit())],
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Configuracion'),
          ),
          body: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Center(
                      child: Container(
                    margin: const EdgeInsets.all(24),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 55,
                          ),
                          Text(
                            'Tema de aplicacion',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 55,
                          ),
                          Flexible(child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1,
                              vertical: size.height * 0.025,
                            ),
                            children: [
                              CustomRadioTheme(
                                  isSelectedId: 1,
                                  id: 1,
                                  icon: Icons.light_mode,
                                  name: 'Luminoso',
                                  onPressed: () {
                                    context
                                        .read<ThemeCubit>()
                                        .updateTheme(ThemeMode.light);
                                  }
                              ),
                              CustomRadioTheme(
                                  isSelectedId: 1,
                                  id: 2,
                                  icon: Icons.dark_mode,
                                  name: 'Oscuro',
                                  onPressed: () {
                                    context
                                        .read<ThemeCubit>()
                                        .updateTheme(ThemeMode.dark);
                                  }
                              ),
                              CustomRadioTheme(
                                  isSelectedId: 1,
                                  id: 0,
                                  icon: Icons.invert_colors,
                                  name: 'Sistema',
                                  onPressed: () {
                                    context
                                        .read<ThemeCubit>()
                                        .updateTheme(ThemeMode.system);
                                  }
                              ),
                            ],
                          )),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text('Seleccione el tema de Visualizacion'),
                          const Spacer()
                        ],
                      ),
                    ),
                  )
                ],

          )),
    );
  }
}
