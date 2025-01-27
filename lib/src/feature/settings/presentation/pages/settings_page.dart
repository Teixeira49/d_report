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
      body: SingleChildScrollView(
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
                  children: [
                    ButtonSettingsTileDynamicIcon(
                      titleOptionText: 'Tema de la aplicacion',
                      iconLight: Icons.brightness_medium,
                      iconDark: Icons.dark_mode,
                      route: '/main/config/edit/',
                      arguments: argument,
                      getIndex: 0,
                    ),
                    const SizedBox(height: 4,)
                  ],
                ),
                const Divider(color: Colors.transparent,),
                ExpansionTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: const Text("Cuenta"),
                  children: [
                    ButtonSettingsTile(
                      titleOptionText: 'Mi cuenta',
                      iconData: Icons.account_circle,
                      route: '/main/config/edit/',
                      arguments: argument,
                    ),
                    ButtonSettingsTile(
                      titleOptionText: 'Cambiar Contraseña',
                      iconData: Icons.password,
                      route: '/main/config/edit/',
                      arguments: argument,
                    ),
                    const SizedBox(height: 4,)
                  ],
                ),
                const Divider(color: Colors.transparent,),
                ExpansionTile(
                  title: const Text("Politicas de Privacidad"),
                  leading: Icon(
                    Icons.privacy_tip,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  children: [
                    ButtonSettingsTile(
                      titleOptionText: 'Terminos y Condiciones',
                      iconData: Icons.info,
                      route: '/main/config/edit/', arguments: argument,
                      getIndex: 1,
                      //voidCallback: controller.jumpToPage(1),
                    ),
                    const ButtonSettingsTileWithLink(
                      titleOptionText: 'Sobre la empresa',
                      iconData: Icons.factory,
                      url: 'https://www.google.com',
                    ),
                    const SizedBox(height: 4,)                  ],
                ),
                const Divider(color: Colors.transparent,),
                ExpansionTile(
                  title: const Text("Sobre la Aplicacion"),
                  leading: Icon(
                    Icons.touch_app,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  children: [
                    const ButtonSettingsTileWithLink(
                      titleOptionText: 'Informar de un problema',
                      iconData: Icons.flag,
                        url: 'https://www.google.com',
                    ),
                    ButtonSettingsTile(
                      titleOptionText: 'Version de la aplicacion',
                      iconData: Icons.perm_device_info,
                      route: '/main/config/edit/', arguments: argument,
                      getIndex: 2,
                    ),
                    const SizedBox(height: 4,)
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
