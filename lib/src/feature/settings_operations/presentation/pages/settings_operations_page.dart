import 'package:d_report/src/core/utils/constants/text_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../shared/presentation/cubit/theme_cubit.dart';
import '../widgets/theme_selector.dart';

class SettingsOperationsPage extends StatefulWidget {
  const SettingsOperationsPage({super.key});

  @override
  MySettingOperationsState createState() => MySettingOperationsState();
}

class MySettingOperationsState extends State<SettingsOperationsPage> {
  late final int initialPage;
  late final int themeC;

  late final PageController _pageController;

  bool _isInit = true;
  int indexButton = 0;
  String _version = 'Cargando...';

  @override
  void initState() {
    _isInit = true;
    super.initState();
    _loadVersion();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      dynamic args = ModalRoute.of(context)!.settings.arguments;
      initialPage = (args['id'] != null) ? args['id'] : 1;
      _pageController = PageController(initialPage: initialPage);
      themeC = (args['number'] != null) ? args['number'] : 0;
      indexButton = themeC;
    }
    super.didChangeDependencies();
    _isInit = false;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${packageInfo.version}+${packageInfo.buildNumber}';
    });
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
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      Flexible(
                          child: Wrap(
                        //padding: EdgeInsets.symmetric(
                        //  horizontal: size.width * 0.1,
                        //  vertical: size.height * 0.025,
                        //),
                        children: [
                          CustomRadioTheme(
                              isSelectedId: indexButton,
                              id: 1,
                              icon: Icons.light_mode,
                              name: 'Luminoso',
                              onPressed: () {
                                context
                                    .read<ThemeCubit>()
                                    .updateTheme(ThemeMode.light);
                                setState(() {
                                  indexButton = 1;
                                });
                              }),
                          CustomRadioTheme(
                              isSelectedId: indexButton,
                              id: 2,
                              icon: Icons.dark_mode,
                              name: 'Oscuro',
                              onPressed: () {
                                context
                                    .read<ThemeCubit>()
                                    .updateTheme(ThemeMode.dark);
                                setState(() {
                                  indexButton = 2;
                                });
                              }),
                          CustomRadioTheme(
                              isSelectedId: indexButton,
                              id: 0,
                              icon: Icons.invert_colors,
                              name: 'Sistema',
                              onPressed: () {
                                context
                                    .read<ThemeCubit>()
                                    .updateTheme(ThemeMode.system);
                                setState(() {
                                  indexButton = 0;
                                });
                              }),
                        ],
                      )),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 5,
                              height: 5,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 7),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Se ajustara la apariencia de la aplicacion segun la configuracion escogida.',
                                textAlign: TextAlign.justify,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: size.height * 0.25,
                      ),
                      child: IntrinsicHeight(
                          child: Container(
                              margin: const EdgeInsets.all(24),
                              // TODO CREATE CONSTANT
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const SizedBox(height: 24,),
                                  Text(
                                    'Politicas de Privacidad',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 24,),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 24),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    boxShadow: [BoxShadow(
                                      color: Theme.of(context).colorScheme.shadow.withOpacity(0.45),
                                      blurRadius: 11,
                                      offset: const Offset(0, 3),
                                    )]
                                ),
                                child: Text(
                                  termsOfPrivacy,
                                  style:
                                  Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.justify,
                                ),
                              )

                                ],
                              ))))),
              Container(
                margin: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 55,
                    ),
                    Text(
                      'Version de la aplicacion',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    Container(
                      margin: const EdgeInsets.all(24 * 2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 36),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Theme.of(context).colorScheme.onPrimary,
                        boxShadow: [BoxShadow(
                          color: Theme.of(context).colorScheme.shadow.withOpacity(0.45),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 125,
                            height: 125,
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Version: $_version',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const Text(
                            '\nTodos los derechos reservados.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
