import 'package:flutter/material.dart';

class MainPage extends StatelessWidget{

  const MainPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(

        appBar: AppBar(
          title: const Text("D_Project"),
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
        ),

        body: Center(
          child: TextFormField(

          )
          //OutlinedButton(
              //onPressed: () {
              //  Navigator.of(context).pushReplacementNamed('/main/');
              //},
              //child: const Text("Click to load data")
          //),
        )
    );
  }
}