import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/feature/auth/presentation/widgets/user_field.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../widgets/login_button.dart';
import '../widgets/password_field.dart';

final _formatKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget{

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Scaffold(

        appBar: AppBar(
          title: const Text("D_Project"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          //    .inversePrimary,
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
                  child: Form(
                    key: _formatKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children:[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                  shape: BoxShape.circle
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.0075,
                                vertical: size.height * 0.025,
                              ),
                              child: Image.asset("assets/images/logo.png", width: MediaQuery.of(context).size.width/1.5, height: MediaQuery.of(context).size.width/1.5 ),
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.075,
                                  vertical: size.height * 0.025,
                                ),
                                child: const UserAccountTextField()
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.075,
                                  vertical: size.height * 0.025,
                                ),
                                child: const PasswordTextField()
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    top: size.height / 60,
                                    bottom: 0.25
                                ),
                                child: const LoginButton()
                            ),
                            TextButton(
                              child: const Text("Register", style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/auth/register/');
                              },
                            )
                          ]
                      )
                  )
                )
              ),
          )
        )
    );
  }
}