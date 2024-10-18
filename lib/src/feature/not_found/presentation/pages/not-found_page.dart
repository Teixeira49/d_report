import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/not-found_button.dart';


class NotFoundPage extends StatelessWidget{

  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    double sizeIcon = size.shortestSide * 0.50;

    return Scaffold(

        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: true,
        ),

        body: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height * 0.25,
                ),
              child: IntrinsicHeight(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children:[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.0025,
                      vertical: size.height * 0.0025,
                    ),
                    child: Image.asset(
                      "assets/images/not_found_logo.png",
                    ),
                  ),
                  const Text('Error 404:', style: TextStyle(fontSize: 32)),
                  const Text('Modulo no Encontrado', style: TextStyle(fontSize: 18)),
                  Container(
                    padding: EdgeInsets.only(
                      top: size.height * 0.055,
                      bottom: size.height * 0.15,
                    ),
                    child: const NotFoundExitButton()
                  ),
                ]
            )
          )
        )
        )
        )
    );
  }
}