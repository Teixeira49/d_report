import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BottomBarMainPanel extends StatelessWidget {
  const BottomBarMainPanel(
      {super.key, required this.currentPage, this.parseArguments});

  final int currentPage;
  final dynamic parseArguments;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        if (index != currentPage) {
          switch (index) {
            case 1:
              Navigator.of(context).pushReplacementNamed('/main/patients/find/',
                  arguments: parseArguments);
              break;
            case 0:
              Navigator.of(context).pushReplacementNamed('/main/patients/',
                  arguments: parseArguments);
              break;
          }
        }
      },
      backgroundColor: ThemeData().bottomNavigationBarTheme.backgroundColor,
      selectedItemColor: ThemeData().bottomNavigationBarTheme.selectedItemColor,
      selectedLabelStyle:
          ThemeData().bottomNavigationBarTheme.selectedLabelStyle,
      currentIndex: currentPage,
      items: [
        BottomNavigationBarItem(
          activeIcon: Container(
            width: 60,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer
                  .withOpacity(0.55),
              borderRadius: const BorderRadius.all(Radius.elliptical(20, 30)),
            ),
            child: const Icon(Icons.house),
          ),
          icon: const Icon(Icons.house_outlined),
          label: 'Mis Casos',
        ),
        BottomNavigationBarItem(
          activeIcon: Container(
            width: 60,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer
                  .withOpacity(0.55),
              borderRadius: const BorderRadius.all(Radius.elliptical(20, 30)),
            ),
            child: const Icon(Icons.folder_copy),
          ),
          icon: const Icon(Icons.folder_copy_outlined),
          label: 'Buscar Expediente',
        ),
      ],
    );
  }
}
