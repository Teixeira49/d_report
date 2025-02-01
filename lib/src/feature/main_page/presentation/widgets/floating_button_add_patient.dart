import 'package:d_report/my_flutter_app_icons.dart';
import 'package:d_report/src/shared/data/model/roles.dart';
import 'package:flutter/material.dart';

import '../../../../shared/presentation/widget/bullet.dart';

class FloatingActionButtonAddPatient extends StatelessWidget {
  const FloatingActionButtonAddPatient({
    super.key,
    required this.roleId,
    required this.currentPage,
    required this.isSearching,
    this.parseArguments,
    required this.size,
  });

  final int roleId;
  final int currentPage;
  final bool isSearching;
  final dynamic parseArguments;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: ((currentPage == 0) &&
          (roleId == UserRole.DOCTOR.index) &&
          !isSearching),
      child: FloatingActionButton(
        backgroundColor: ThemeData().floatingActionButtonTheme.backgroundColor,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
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
                            title: const Text('Crear Caso - Nuevo Paciente'),
                            dense: true,
                            tileColor: Colors.transparent,
                            focusColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            trailing: const Icon(
                              MyFlutterApp.user_plus,
                              size: 22,
                            ),
                            leading: const BulletDecorator(
                              sizeBullet: 5,
                              marginHorizontal: 6,
                              marginVertical: 7,
                            ),
                            minLeadingWidth: 2,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushNamed(
                                  '/main/new-case/new-patient',
                                  arguments: parseArguments);
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.010,
                          ),
                          child: ListTile(
                            title:
                                const Text('Crear Caso - Paciente Existente'),
                            dense: true,
                            tileColor: Colors.transparent,
                            focusColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            trailing: const Icon(
                              MyFlutterApp.user_check,
                              size: 22,
                            ),
                            leading: const BulletDecorator(
                              sizeBullet: 5,
                              marginHorizontal: 6,
                              marginVertical: 7,
                            ),
                            minLeadingWidth: 2,
                            onTap: () {

                              Navigator.pop(context);
                              Navigator.of(context).pushNamed(
                                  '/main/new-case/find-patient',
                                  arguments: parseArguments);
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
    );
  }
}
