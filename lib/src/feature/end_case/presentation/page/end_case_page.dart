

import 'package:flutter/material.dart';

class EndCasePage extends StatelessWidget {

  const EndCasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Fin del caso'),
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
      ),

      body: Container(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}