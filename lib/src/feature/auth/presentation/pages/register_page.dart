import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import 'package:d_report/src/feature/auth/presentation/widgets/lastname_field.dart';

import 'package:flutter/material.dart';

import '../widgets/firstname_field.dart';
import '../widgets/password_field.dart';
import '../widgets/register_button.dart';
import '../widgets/type-user_field.dart';
import '../widgets/user_field.dart';
import '../widgets/validate-password_field.dart';

final _formatKey2 = GlobalKey<FormState>();

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class RegisterPage extends StatelessWidget{

  const RegisterPage({super.key});

  // https://medium.com/flutter-community/create-custom-radio-input-in-flutter-8d94a273d374
  // https://fluttergems.dev/packages/selectable_list/

  // Agregar Para telefono tambien

  // Agregar rol al que aplica con botones como los de arriba

  // Agregar una lista de Especialidades, con un Otros

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Scaffold(

        appBar: AppBar(
          title: Text(
              registerData + space + user,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          centerTitle: true,
          //titleTextStyle: TextStyle(color: Theme.of(context).primaryColor),
        //  automaticallyImplyLeading: true,
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
                    child: UserAccountTextField(controllerData: _emailController,)
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.075,
                      vertical: size.height * 0.025,
                    ),
                    child: PasswordTextField(password: password, controllerData: _passwordController,)
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.075,
                      vertical: size.height * 0.025,
                    ),
                    child: PasswordTextField(password: password, controllerData: _passwordController,)
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