import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import 'package:d_report/src/feature/main_page/domain/entities/patient.dart';
import 'package:flutter/material.dart';

import '../widgets/current_case.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MyMainPageState createState() => MyMainPageState();

}

class MyMainPageState extends State<MainPage> {

  int _currentPage = 1;

  @override
  Widget build(BuildContext context){

    var userName = "Pepe loco";
    var accountEmail = "Pepeloco@gmail.com";
    var accountName = "Doctor"; // TODO take name for back
    var img = "";
    final size = MediaQuery.of(context).size;

    //List<Patients> patients = [];
    List<Patient> regularP = [
      Patient(id:1, name:"Jose", lastname: "Peres", age: 15, codHab: 'A-606'),
      Patient(id:2, name:"Manu", lastname: "Peres", age: 15, codHab: 'A-606'),
      Patient(id:3, name:"Miguel", lastname: "Peres", age: 15, codHab: 'A-606'),
      Patient(id:4, name:"Leo", lastname: "Peres", age: 15, codHab: 'A-606'),
    ];
    List<Patient> currentP = [
      Patient(id:5, name:"A", lastname: "Peres", age: 15, codHab: 'A-606'),
      Patient(id:6, name:"B", lastname: "Peres", age: 15, codHab: 'A-606'),
      Patient(id:7, name:"C", lastname: "Peres", age: 15, codHab: 'A-606'),
      Patient(id:8, name:"D", lastname: "Peres", age: 15, codHab: 'A-606'),
    ];

    List<Widget> pages = [
      CurrentCasesPage(currentP),
      CurrentCasesPage(regularP),
      CurrentCasesPage(currentP)
    ];

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(

      key: scaffoldKey,

        appBar: AppBar(
          title: Row(
            children: [
              GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: img == "" ? Image.asset("assets/images/logo.png") : Image.asset(img),
                ),
                onTap: () {
                  print('Se presionó el CircleAvatar');
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
              const SizedBox(width: 12),
              Text(accountName),
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

        drawer: Drawer(
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
                          child: img == "" ? Image.asset("assets/images/logo.png") : Image.asset(img),
                        ),
                        const SizedBox(height: 4,),
                        Text(
                          userName != "" ? accountName + point + userName : 'Nombre de usuario',
                          style: const TextStyle(color: Colors.white, fontSize: 18), // TODO Add colors to palette
                        ),
                        Text(
                          accountEmail ?? 'correo@ejemplo.com',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Principal'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.5)
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.of(context).pushNamed('/main/patients/');
                      });
                      print("pepe");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      setState(() {
                        Navigator.of(context).pushNamed('/main/profile/');
                      });
                      print("pepe");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Configuracion'),
                    onTap: () {
                      setState(() {
                          Navigator.of(context).pushNamed('/main/config/');
                      });
                      print("pepe");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Cerrar sesion'),
                    onTap: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      print("Se presiono cerrar sesion");
                    },
                  ),
                  Divider(color: Theme.of(context).colorScheme.outline,),
                ]
            ),
          ),

        body: GestureDetector(
          child: pages[_currentPage],
          onHorizontalDragStart: (DragStartDetails details) {
            if (details.globalPosition.dx < 100) {
              scaffoldKey.currentState?.openDrawer();
            }
          },
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: ThemeData().floatingActionButtonTheme.backgroundColor,
          child: const Icon(Icons.add),
          onPressed: () {
            print("pepe");
          },

        ),

        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          backgroundColor: ThemeData().bottomNavigationBarTheme.backgroundColor,
          selectedItemColor: ThemeData().bottomNavigationBarTheme.selectedItemColor,
          currentIndex: _currentPage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.stacked_bar_chart_rounded
              ),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.other_houses_outlined
              ),
              label: 'Active Cases',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.folder_copy
              ),
              label: 'Search Case',
            ),
      ],

      ),

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}