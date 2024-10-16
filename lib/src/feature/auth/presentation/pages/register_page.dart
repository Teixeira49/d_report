import 'package:d_report/src/feature/auth/presentation/widgets/lastname_field.dart';
import 'package:flutter/material.dart';

import '../widgets/firstname_field.dart';
import '../widgets/password_field.dart';
import '../widgets/register_button.dart';
import '../widgets/type-user_field.dart';
import '../widgets/user_field.dart';
import '../widgets/validate-password_field.dart';

final _formatKey2 = GlobalKey<FormState>();

class RegisterPage extends StatelessWidget{

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Scaffold(

        appBar: AppBar(
          title: const Text("D_Project"),
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          centerTitle: true,
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
                      horizontal: size.width * 0.075,
                      vertical: size.height * 0.025,
                    ),
                    child: const FirstNameTextField()
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.075,
                      vertical: size.height * 0.025,
                    ),
                    child: const LastNameTextField()
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.075,
                      vertical: size.height * 0.025,
                    ),
                    child: const TypeUserDropdownField()
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
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.075,
                      vertical: size.height * 0.025,
                    ),
                    child: const ValidatePasswordTextField()
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: size.height / 60,
                        bottom: 0.25
                    ),
                    child: const RegisterButton(),
                  )
                ]
              )
            )
            )
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