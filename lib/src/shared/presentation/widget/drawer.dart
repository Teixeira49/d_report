import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import '../../domain/entities/user.dart';


class NavigatorDrawer extends StatefulWidget {

  const NavigatorDrawer({super.key, required this.user});

  final User user;

  @override
  MyNavigatorDrawerState createState() => MyNavigatorDrawerState();

}

class MyNavigatorDrawerState extends State<NavigatorDrawer> {

  @override
  Widget build(BuildContext context) {

    return Drawer(
      surfaceTintColor: Theme.of(context).drawerTheme.surfaceTintColor,
      shadowColor: Theme.of(context).drawerTheme.shadowColor,
      child:
      ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
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
                      child: widget.user.userImgUrl == "" ? Image.asset("assets/images/logo.png") : Image.asset(widget.user.userImgUrl), // TODO volver constante
                    ),
                    const SizedBox(height: 4,),
                    Text(
                      widget.user.userName != "" ? widget.user.userRole + point + widget.user.userName : 'Nombre de usuario',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 18
                      ),
                    ),
                    Text(
                      widget.user.userEmail ?? 'correo@ejemplo.com',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary
                      ),
                    ),
                  ],
                )
            ),
            ListTile( // TODO Change ModalRoute for Navigator, and replace string route for a more than serius code
              leading: Icon(
                Icons.home,
                color: ModalRoute.of(context)?.settings.name == '/main/patients/' ?
                Theme.of(context).colorScheme.primary :
                Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'Principal',
                style: TextStyle(
                    color: ModalRoute.of(context)?.settings.name == '/main/patients/' ?
                    Theme.of(context).colorScheme.primary :
                    Theme.of(context).iconTheme.color,
                    fontSize: Theme.of(context).listTileTheme.titleTextStyle?.fontSize
                ),
              ),
              tileColor: Colors.transparent, // Add to Theme palette
              shape: Theme.of(context).listTileTheme.shape,
              onTap: () {
                setState(() {
                  if (ModalRoute.of(context)?.settings.name != '/main/patients/'){
                    Navigator.of(context).pushNamed(
                        '/main/patients/',
                        arguments: { "userData" : User(userName: "Pepe Loco", userEmail: "Pepeloco@gmail.com", userRole: "Doctor", userImgUrl: "")}
                    );
                  }
                });
                print("pepe");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: ModalRoute.of(context)?.settings.name == '/main/profile/' ?
                Theme.of(context).colorScheme.primary :
                Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                    color: ModalRoute.of(context)?.settings.name == '/main/profile/' ?
                    Theme.of(context).colorScheme.primary :
                    Theme.of(context).iconTheme.color,
                    fontSize: Theme.of(context).listTileTheme.titleTextStyle?.fontSize
                ),
              ),
              tileColor: Colors.transparent, // Add to Theme palette
              shape: Theme.of(context).listTileTheme.shape,
              onTap: () {
                setState(() {
                  if (ModalRoute.of(context)?.settings.name != '/main/profile/') {
                    Navigator.of(context).pushNamed(
                        '/main/profile/',
                        arguments: { "userData" : User(userName: "Pepe Loco", userEmail: "Pepeloco@gmail.com", userRole: "Doctor", userImgUrl: "")}
                    );
                  }
                });
                print("pepe");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: ModalRoute.of(context)?.settings.name == '/main/config/' ?
                Theme.of(context).colorScheme.primary :
                Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'Configuracion',
                style: TextStyle(
                    color: ModalRoute.of(context)?.settings.name == '/main/config/' ?
                    Theme.of(context).colorScheme.primary :
                    Theme.of(context).iconTheme.color,
                    fontSize: Theme.of(context).listTileTheme.titleTextStyle?.fontSize
                ),
              ),
              tileColor: Colors.transparent, // Add to Theme palette
              shape: Theme.of(context).listTileTheme.shape,
              onTap: () {
                setState(() {
                  if (ModalRoute.of(context)?.settings.name != '/main/config/'){
                    Navigator.of(context).pushNamed(
                        '/main/config/',
                        arguments: { "userData" : User(userName: "Pepe Loco", userEmail: "Pepeloco@gmail.com", userRole: "Doctor", userImgUrl: "")}
                    );
                  }
                });
                print("pepe");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                  'Cerrar sesion',
                  style: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: Theme.of(context).listTileTheme.titleTextStyle?.fontSize
                  )
              ),
              tileColor: Colors.transparent, // Add to Theme palette
              shape: Theme.of(context).listTileTheme.shape,
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                print("Se presiono cerrar sesion");
              },
            ),
            Divider(color: Theme.of(context).colorScheme.outline,),
          ]
      ),
    );
  }
}