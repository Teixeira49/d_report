import 'package:d_report/src/feature/auth/presentation/cubit/login_auth_cubit/auth_user_state.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import 'package:d_report/src/feature/auth/presentation/widgets/user_field.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/network/network_info.dart';
import '../../../../shared/presentation/widget/circular_progress_bar.dart';
import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../../data/datasource/remote/auth_user_remote_datasource.dart';
import '../../data/repository/auth_user_repository_impl.dart';
import '../cubit/login_auth_cubit/auth_user_cubit.dart';
import '../widgets/login_button.dart';
import '../widgets/register_button.dart';
import '../widgets/password_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  MyLoginPageState createState() => MyLoginPageState();
}

class MyLoginPageState extends State<LoginPage> {
  String _version = 'Cargando...';

  @override
  void initState() {
    _loadVersion();
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

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${packageInfo.version}+${packageInfo.buildNumber}';
    });
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
                  Navigator.of(context).pushNamed('/main/patients/',
                      arguments: {
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.transparent),
                                      shape: BoxShape.circle),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.0075,
                                    vertical: size.height * 0.025,
                                  ),
                                  child: Image.asset("assets/images/logo.png",
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              1.5),
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
                                Container(
                                    child: (state is AuthLoading)
                                        ? const Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                                SizedBox(
                                                  height: 60,
                                                ),
                                                CustomCircularProgressBar(),
                                                SizedBox(
                                                  height: 45.5,
                                                )
                                              ])
                                        : Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              LoginButton(
                                                username: _emailController.text,
                                                password:
                                                    _passwordController.text,
                                                formKey: _formKey,
                                                size: size,
                                              ),
                                              RegisterButton(
                                                size: size,
                                              )
                                            ],
                                          )),
                              ])))),
            ));
          },
        ),
        bottomSheet: Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.copyright, size: 14,),
            const SizedBox(width: 6,),
            Text("Version: ${_version != 'Cargando...' ? _version : ''}. Hospital J.M. de los Rios."),
          ],),
        ),
      ),
    );
  }
}
