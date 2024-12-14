import 'package:d_report/src/feature/auth/presentation/cubit/login_auth_cubit/auth_user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import 'package:d_report/src/feature/auth/presentation/widgets/user_field.dart';

import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/network/network_info.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widget/circular_progress_bar.dart';
import '../../../../shared/presentation/widget/floating_snackbars.dart';
import '../../data/datasource/remote/auth_user_remote_datasource.dart';
import '../../data/repository/auth_user_repository_impl.dart';
import '../cubit/login_auth_cubit/auth_user_cubit.dart';
import '../widgets/login_button.dart';
import '../widgets/password_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  MyLoginPageState createState() => MyLoginPageState();
}

class MyLoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = AuthUserRemoteDataSourceImpl();
    final network = InternetConnectionChecker();
    final repository = AuthRepositoryImpl(
        remoteDataSource: remoteDataSource,
        networkInfo: NetworkInfoImpl(network));

    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => AuthCubit(repository),
      child: Scaffold(

          /*appBar: AppBar(
          title: const Text("D_Project"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          //    .inversePrimary,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),*/

          body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          //if (state is AuthInitial) {
          //  return Container();
          //} else if (state is AuthLoading) {
          //  return Center(child: CircularProgressIndicator());
          if (state is AuthLoaded) {
            print(state.authUser.accessToken);
            Future.delayed(const Duration(seconds: 1), () {
              if (mounted) {
                Navigator.of(context).pushNamed('/main/patients/', arguments: {
                  "userData": state.user,
                  "AuthCredentials": state.authUser
                });
              }
            });
          } else if (state is AuthError) {
            FloatingWarningSnackBar.show(context, state.errorSMS);
          }
        },
        builder: (context, state) {
          return Center(
              child: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height * 0.25,
                ),
                child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.transparent),
                            shape: BoxShape.circle),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.0075,
                          vertical: size.height * 0.025,
                        ),
                        child: Image.asset("assets/images/logo.png",
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: MediaQuery.of(context).size.width / 1.5),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.075,
                            vertical: size.height * 0.025,
                          ),
                          child: UserAccountTextField(
                              controllerData: _emailController)),
                      Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.075,
                            vertical: size.height * 0.025,
                          ),
                          child: PasswordTextField(
                              password: password,
                              controllerData: _passwordController)),
                      Expanded( // Make global el progress
                        child: (state is AuthLoading) ? const

                        Column(children: [SizedBox(height: 30,),
                          CustomCircularProgressBar(),
                          SizedBox(height: 30,)
                        ]) : Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                    top: size.height / 20, bottom: 0.25),
                                child: LoginButton(
                                  username: _emailController.text,
                                  password: _passwordController.text,
                                  formKey: _formKey,
                                )),
                            TextButton(
                              child: Text(registerData,
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.tertiary)),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/auth/register/');
                              },
                            ),
                          ],
                        )
                      )
                    ])))),
          ));
        },
      )),
    );
  }
}
