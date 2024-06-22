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
    List<String> patients = ["manu", 'jose'];
    List<String> pepe = ["pepe", 'jos1123e'];
    List<Widget> pages = [
      CurrentCasesPage(pepe),
      CurrentCasesPage(patients),
      CurrentCasesPage(pepe)
    ];

    return Scaffold(

        appBar: AppBar(
          title: Text(accountName),
          backgroundColor: Theme
              .of(context)
              .colorScheme.primary,
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