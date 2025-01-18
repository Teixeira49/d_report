import 'package:flutter/material.dart';

import '../../domain/entities/auth_user.dart';
import '../../domain/entities/user.dart';

class NavigatorDrawer extends StatefulWidget {
  const NavigatorDrawer(
      {super.key, required this.user, required this.authUser});

  final User user;
  final AuthUser authUser;

  @override
  MyNavigatorDrawerState createState() => MyNavigatorDrawerState();
}

class MyNavigatorDrawerState extends State<NavigatorDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Theme.of(context).drawerTheme.surfaceTintColor,
      shadowColor: Theme.of(context).drawerTheme.shadowColor,
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: widget.user.userImgUrl == ""
                      ? Image.asset("assets/images/logo.png")
                      : Image.asset(
                          widget.user.userImgUrl), // TODO volver constante
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.user.userName != ""
                      ? widget.user.userName
                      : 'Nombre de usuario',
                  // widget.user.userRoleUid + point +
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 18),
                ),
                Text(
                  widget.user.userEmail,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              ],
            )),
        ListTile(
          leading: ModalRoute.of(context)?.settings.name == '/main/patients/'
              ? Icon(Icons.home, color: Theme.of(context).colorScheme.primary)
              : Icon(
                  Icons.home_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
          title: Text(
            'Principal',
            style: TextStyle(
                color:
                    ModalRoute.of(context)?.settings.name == '/main/patients/'
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).iconTheme.color,
                fontSize:
                    Theme.of(context).listTileTheme.titleTextStyle?.fontSize),
          ),
          tileColor: Colors.transparent,
          // Add to Theme palette
          shape: Theme.of(context).listTileTheme.shape,
          onTap: () {
            setState(() {
              if (ModalRoute.of(context)?.settings.name != '/main/patients/') {
                Navigator.of(context).pushReplacementNamed('/main/patients/',
                    arguments: {
                      "userData": widget.user,
                      "AuthCredentials": widget.authUser
                    });
              }
            });
          },
        ),
        ListTile(
          leading: ModalRoute.of(context)?.settings.name == '/main/profile/'
              ? Icon(Icons.person, color: Theme.of(context).colorScheme.primary)
              : Icon(
                  Icons.person_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
          title: Text(
            'Profile',
            style: TextStyle(
                color: ModalRoute.of(context)?.settings.name == '/main/profile/'
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).iconTheme.color,
                fontSize:
                    Theme.of(context).listTileTheme.titleTextStyle?.fontSize),
          ),
          tileColor: Colors.transparent,
          // Add to Theme palette
          shape: Theme.of(context).listTileTheme.shape,
          onTap: () {
            setState(() {
              if (ModalRoute.of(context)?.settings.name != '/main/profile/') {
                Navigator.of(context).pushReplacementNamed('/main/profile/',
                    arguments: {
                      "userData": widget.user,
                      "AuthCredentials": widget.authUser
                    });
              }
            });
          },
        ),
        ListTile(
          leading: ModalRoute.of(context)?.settings.name == '/main/config/'
              ? Icon(Icons.settings,
                  color: Theme.of(context).colorScheme.primary)
              : Icon(
                  Icons.settings_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
          title: Text(
            'Configuracion',
            style: TextStyle(
                color: ModalRoute.of(context)?.settings.name == '/main/config/'
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).iconTheme.color,
                fontSize:
                    Theme.of(context).listTileTheme.titleTextStyle?.fontSize),
          ),
          tileColor: Colors.transparent,
          // Add to Theme palette
          shape: Theme.of(context).listTileTheme.shape,
          onTap: () {
            setState(() {
              if (ModalRoute.of(context)?.settings.name != '/main/config/') {
                Navigator.of(context).pushReplacementNamed('/main/config/', arguments: {
                  "userData": widget.user,
                  "AuthCredentials": widget.authUser
                });
              }
            });
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Theme.of(context).iconTheme.color,
          ),
          title: Text('Cerrar sesion',
              style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: Theme.of(context)
                      .listTileTheme
                      .titleTextStyle
                      ?.fontSize)),
          tileColor: Colors.transparent,
          // Add to Theme palette
          shape: Theme.of(context).listTileTheme.shape,
          onTap: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
        Divider(
          color: Theme.of(context).colorScheme.outline,
        ),
      ]),
    );
  }
}
