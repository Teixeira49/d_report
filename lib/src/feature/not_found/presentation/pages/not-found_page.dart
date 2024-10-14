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
          title: const Text("D_Project"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          automaticallyImplyLeading: false,
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
                      horizontal: size.width * 0.095,
                      vertical: size.height * 0.025,
                    ),
                    child: Icon(
                        Icons.warning_rounded,
                      color: Colors.black12,
                      size: sizeIcon,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.black),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.095,
                      vertical: size.height * 0.055,
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text('Error 404:', style: TextStyle(fontSize: 32),),
                        ),
                        Expanded(
                          child: Text('Page Not Found', style: TextStyle(fontSize: 18),),
                        )
                      ],
                    )
                  ),
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