import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/drawer.dart';
import '../widgets/button_tile.dart';
import '../widgets/button_tile_dynamic_icon.dart';
import '../widgets/button_tile_with_link.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});


  @override
  Widget build(BuildContext context) {

    PageController controller = PageController();

    final size = MediaQuery.of(context).size;

    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    User user = argument["userData"];
    AuthUser authUser = argument["AuthCredentials"];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Configuracion'),
          automaticallyImplyLeading: true,
        ),
        drawer: NavigatorDrawer(
          user: user,
          authUser: authUser,
        ),
        body: PageView(
          controller: controller,
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height * 0.25,
                ),
                child: IntrinsicHeight(
                    child: Container(
                  margin: const EdgeInsets.all(24), // TODO CREATE CONSTANT
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ExpansionTile(
                        title: const Text("Tema"),
                        leading: Icon(
                          Icons.invert_colors,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        children: const [
                          ButtonSettingsTileDynamicIcon(
                            titleOptionText: 'Tema de la aplicacion',
                            iconLight: Icons.light_mode,
                            iconDark: Icons.dark_mode,
                            route: '/main/config/edit/',
                            arguments: {},
                            getIndex: 1,
                          ),
                        ],
                      ),
                      const Divider(),
                      ExpansionTile(
                        leading: Icon(
                          Icons.person,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        title: const Text("Cuenta"),
                        children: const [
                          ButtonSettingsTile(
                            titleOptionText: 'Mi cuenta',
                            iconData: Icons.account_circle,
                          ),
                          ButtonSettingsTile(
                            titleOptionText: 'Cambiar Contraseña',
                            iconData: Icons.password,
                          ),
                        ],
                      ),
                      const Divider(),
                      ExpansionTile(
                        title: const Text("Politicas de Privacidad"),
                        leading: Icon(
                          Icons.privacy_tip,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        children: const [
                          ButtonSettingsTile(
                            titleOptionText: 'Terminos y Condiciones',
                            iconData: Icons.info,
                            //voidCallback: controller.jumpToPage(1),
                          ),
                          ButtonSettingsTileWithLink(
                            titleOptionText: 'Sobre la empresa',
                            iconData: Icons.factory,
                            url: 'https://www.google.com',
                          ),
                        ],
                      ),
                      const Divider(),
                      ExpansionTile(
                        title: const Text("Sobre la Aplicacion"),
                        leading: Icon(
                          Icons.touch_app,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        children: const [
                          ButtonSettingsTile(
                            titleOptionText: 'Informar de un problema',
                            iconData: Icons.flag,
                          ),
                          ButtonSettingsTile(
                            titleOptionText: 'Version de la aplicacion',
                            iconData: Icons.perm_device_info,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
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
                                Text(
                                  'Politicas de Privacidad',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const Divider(),
                                const Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                              ],
                            )))))
          ],
        ));
  }
}
