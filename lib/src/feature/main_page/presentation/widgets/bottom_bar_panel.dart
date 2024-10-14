import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';


class BottomBarPanel extends StatefulWidget {

  final int _initPage;

  const BottomBarPanel(this._initPage, {super.key});

  @override
  BottomBarPanelState createState() => BottomBarPanelState();

  get initPage {
    return _initPage;
  }
}

class BottomBarPanelState extends State<BottomBarPanel> {


  @override
  Widget build(BuildContext context){

    //final size = MediaQuery //TODO DELETE
    //    .of(context)
    //    .size;
    final initialState = Provider.of<BottomBarPanel>(context);
    var currentPage = initialState.initPage;

    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          currentPage = index;
        });
      },
      backgroundColor: ThemeData().bottomNavigationBarTheme.backgroundColor,
      selectedItemColor: ThemeData().bottomNavigationBarTheme.selectedItemColor,
      currentIndex: currentPage,
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

    );
  }
}



