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

    var accountName = "Doctor"; // TODO take name for back
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

    return Scaffold(

        appBar: AppBar(
          title: Row(
            children: [
              GestureDetector(
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person),
                ),
                onLongPress: () {
                  print('Se presionó el CircleAvatar');
                  //Navigator.pushNamed(context, '/perfil');
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
          backgroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,

        ),

        body: pages[_currentPage],
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

      backgroundColor: ThemeData().scaffoldBackgroundColor,
    );
  }
}