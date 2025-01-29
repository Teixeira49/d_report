import 'package:d_report/my_flutter_app_icons.dart';
import 'package:d_report/src/core/utils/constants/fields_constants.dart';
import 'package:d_report/src/feature/auth_register/data/datasource/remote/account_remote_data_source.dart';
import 'package:d_report/src/feature/auth_register/domain/entities/create_account_request.dart';
import 'package:d_report/src/feature/auth_register/domain/use_cases/check_account.dart';
import 'package:d_report/src/feature/auth_register/presentation/cubit/register_auth_cubit/register_auth_cubit.dart';
import 'package:d_report/src/feature/auth_register/presentation/cubit/register_button_cubit/register_button_cubit.dart';
import 'package:d_report/src/feature/auth_register/presentation/widgets/lastname_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/helpers/helpers.dart';
import '../../../../shared/presentation/widget/floating_snack_bars.dart';
import '../../../../shared/presentation/widget/loading_show_dialog.dart';
import '../../domain/entities/gender.dart';
import '../../domain/repositories/register_account_repository.dart';
import '../../domain/use_cases/post_new_account.dart';
import '../cubit/register_auth_cubit/register_auth_state.dart';
import '../cubit/register_button_cubit/register_button_state.dart';
import '../widgets/firstname_field.dart';
import '../widgets/gender_selector.dart';
import '../widgets/password_field.dart';
import '../widgets/phone_user_field.dart';
import '../widgets/type-user_field.dart';
import '../widgets/user_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  MyRegisterPageState createState() => MyRegisterPageState();
}

class MyRegisterPageState extends State<RegisterPage> {
  // Agregar rol al que aplica con botones como los de arriba

  // Agregar una lista de Especialidades, con un Otros

  final AccountProfileRequest accountProfileRequest = AccountProfileRequest(
      firstName: '',
      lastName: '',
      genre: '',
      email: '',
      phone: '',
      range: '',
      password: '');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordValController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final ValueNotifier<String?> _genderController = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _roleController = ValueNotifier<String?>(null);

  final FocusNode _focusNode = FocusNode();

  List<Gender> genders = [
    Gender("Male", Icons.male, false),
    Gender("Female", Icons.female, false),
    Gender("Others", MyFlutterApp.transgender, false)
  ];

  int _currentPage = 0;
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordValController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _roleController.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  _changePage() {
    _currentPage++;
    _controller.animateToPage(
        _currentPage,
        duration: const Duration(
            milliseconds: 300),
        curve: Curves.easeIn);
  }

  _showFailsMessage(sms) {
      FloatingWarningSnackBar.show(
          context, sms);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final keyboardEnabled = MediaQuery
        .of(context)
        .viewInsets
        .bottom;

    final RegisterAccountRemoteDataSourceImpl accountRemoteDataSource =
    RegisterAccountRemoteDataSourceImpl();
    final AccountRepositoryImpl accountRepositoryImpl =
    AccountRepositoryImpl(accountRemoteDataSource: accountRemoteDataSource);
    final PostNewAccountUseCase postNewAccountUseCase =
    PostNewAccountUseCase(accountRepositoryImpl);
    final CheckAccountUseCase checkAccountUseCase =
    CheckAccountUseCase(accountRepositoryImpl);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  RegisterAuthCubit(
                      checkAccountUseCase, postNewAccountUseCase)),
          BlocProvider(
            create: (_) =>
            RegisterButtonCubit()
              ..selectView(_currentPage),
          )
        ],
        child: BlocConsumer<RegisterAuthCubit, RegisterAuthState>(
          // TODO Change for listener
            listener: (contextFather, stateFather) {
              if (stateFather is RegisterAuthLoading) {
                if (_controller.page == 3) {
                  LoadingShowDialog.show(context, 'Comprobando credenciales');
                } else {
                  LoadingShowDialog.show(context, 'Creando Usuario');
                }
              } else if (stateFather is RegisterAuthLoaded) {
                accountProfileRequest.email = _emailController.text;
                accountProfileRequest.phone = _phoneController.text;
                accountProfileRequest.range = _roleController.value!;
                _changePage();
              } else if (stateFather is RegisterAuthPosted) {
                FloatingSnackBar.show(context, 'Usuario Creado', Icons.check,
                    Colors.green);
                Navigator.of(context).pushNamed('/main/information/', arguments: {'id':0});
              } else if (stateFather is RegisterAuthError) {
                _showFailsMessage(stateFather.errorSMS);
              } else if (stateFather is RegisterTimeoutError) {
                _showFailsMessage(stateFather.errorSMS);
              }
            }, builder: (contextFather, stateFather) {
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    _focusNode.unfocus();
                    if (_currentPage > 0) {
                      setState(() {
                        if (_focusNode.hasFocus) {
                          Future.delayed(const Duration(milliseconds: 360), () {
                            _currentPage--;
                            _controller.animateToPage(_currentPage,
                                duration: const Duration(milliseconds: 300),
                                // TODO refactor
                                curve: Curves.easeIn);
                          });
                        } else {
                          _currentPage--;
                          _controller.animateToPage(_currentPage,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }
                      });
                    } else if (_currentPage == 0) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primaryContainer,
                ),
                title: Text(
                  registerData + space + user,
                  style: Theme
                      .of(context)
                      .appBarTheme
                      .titleTextStyle,
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                //Theme.of(context).scaffoldBackgroundColor,
                automaticallyImplyLeading: false,
                actions: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: totalRegisterPages,
                        effect: JumpingDotEffect(
                          activeDotColor: Theme
                              .of(context)
                              .primaryColor,
                          dotHeight: sizeRegisterBalls,
                          dotWidth: sizeRegisterBalls,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                      controller: _controller,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        //controller.cha
                      },
                      children: [
                        Center(
                            child: SingleChildScrollView(
                                child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: size.height * 0.25,
                                    ),
                                    child: IntrinsicHeight(
                                        child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: size.width *
                                                        0.075,
                                                    vertical: size.height *
                                                        0.020,
                                                  ),
                                                  child: Text(
                                                    'Registro del Usuario',
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Theme
                                                            .of(context)
                                                            .colorScheme
                                                            .primaryContainer),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 37,
                                              ),
                                              SizedBox(
                                                height: 220,
                                                child: Image.asset(
                                                    "assets/images/register/user.png"),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: size.width *
                                                        0.075,
                                                    vertical: size.height *
                                                        0.015,
                                                  ),
                                                  child: FirstNameTextField(
                                                      controller:
                                                      _firstNameController)),
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: size.width *
                                                        0.075,
                                                    vertical: size.height *
                                                        0.015,
                                                  ),
                                                  child: LastNameTextField(
                                                      controller:
                                                      _lastNameController)),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: size.width * 0.1,
                                                  vertical: size.height * 0.020,
                                                ),
                                                child: Text(
                                                  'Porfavor ingrese su nombre y apellido para que otros usuarios puedan conocerlo.',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Theme
                                                          .of(context)
                                                          .colorScheme
                                                          .primaryContainer,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              const Spacer(),
                                            ]))))),
                        Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 55,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.075,
                                    vertical: size.height * 0.025,
                                  ),
                                  child: Text(
                                    'Genero del Usuario',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .primaryContainer),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: 220,
                                  child: Image.asset(
                                      "assets/images/register/gender.png"),
                                ),
                                Flexible(
                                    child: ListView.builder(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.1,
                                          vertical: size.height * 0.025,
                                        ),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: genders.length,
                                        itemBuilder: (subContext,
                                            indexSelector) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                genders.forEach((gender) =>
                                                gender.isSelected = false);
                                                genders[indexSelector]
                                                    .isSelected =
                                                true;
                                                _genderController.value =
                                                    genders[indexSelector].name;
                                              });
                                            },
                                            child:
                                            CustomRadio(genders[indexSelector]),
                                          );
                                        })),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.1,
                                    vertical: size.height * 0.020,
                                  ),
                                  child: Text(
                                    'Porfavor ingrese bajo que pronombre desea que nos dirijamos a usted',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .primaryContainer,
                                        fontSize: 16),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            )),
                        Center(
                          child: SingleChildScrollView(
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: size.height * 0.25,
                                ),
                                child: IntrinsicHeight(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.075,
                                              vertical: size.height * 0.020,
                                            ),
                                            child: Text(
                                              'Cuenta del Usuario',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme
                                                      .of(context)
                                                      .colorScheme
                                                      .primaryContainer),
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      SizedBox(
                                        height: 220,
                                        child: Image.asset(
                                            "assets/images/register/profile.png"),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.075,
                                            vertical: size.height * 0.015,
                                          ),
                                          child: UserAccountTextField(
                                            controllerData: _emailController,
                                          )),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.075,
                                            vertical: size.height * 0.015,
                                          ),
                                          child: PhoneNumberField(
                                            controllerData: _phoneController,
                                            focusNode: _focusNode,
                                          )),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.075,
                                            vertical: size.height * 0.015,
                                          ),
                                          child: TypeUserDropdownField(
                                            valueNotifier: _roleController,
                                          )),
                                      const Spacer()
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Center(
                          child: SingleChildScrollView(
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: size.height * 0.25,
                                ),
                                child: IntrinsicHeight(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.075,
                                              vertical: size.height * 0.020,
                                            ),
                                            child: Text(
                                              'Contraseña',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme
                                                      .of(context)
                                                      .colorScheme
                                                      .primaryContainer),
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      SizedBox(
                                        height: 220,
                                        child: Image.asset(
                                            "assets/images/register/security.png"),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.075,
                                            vertical: size.height * 0.015,
                                          ),
                                          child: PasswordTextField(
                                            password: password,
                                            controllerData: _passwordController,
                                          )),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.075,
                                            vertical: size.height * 0.015,
                                          ),
                                          child: PasswordTextField(
                                            password: password,
                                            controllerData:
                                            _passwordValController,
                                          )),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.1,
                                          vertical: size.height * 0.020,
                                        ),
                                        child: Text(
                                          'Ultimo paso: Porfavor cree una contraseña de acceso al sistema',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Theme
                                                  .of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              fontSize: 16),
                                        ),
                                      ),
                                      const Spacer()
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ]),
                  Visibility(
                      visible: keyboardEnabled == 0,
                      child: BlocConsumer<RegisterButtonCubit,
                          RegisterButtonState>(
                        builder: (subContext, state) {
                          if (state is RegisterButtonLoaded) {
                            return Positioned(
                                bottom: 50,
                                child: Container(
                                    padding:
                                    EdgeInsets.only(top: size.height / 20),
                                    width: size.width * 0.50,
                                    height: size.height * 0.105,
                                    child: MaterialButton(
                                      color:
                                      Theme
                                          .of(context)
                                          .colorScheme
                                          .primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(22.0)),
                                      elevation: 10,
                                      focusColor: Theme
                                          .of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      child: Text(state.registerButtonUser,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.color,
                                              fontFamily: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.fontFamily,
                                              fontSize: 20)),
                                      onPressed: () {
                                        _focusNode.unfocus();

                                        switch (_currentPage) {
                                          case 0:
                                            bool check = subContext
                                                .read<RegisterButtonCubit>()
                                                .checkData([
                                              _firstNameController.text,
                                              _lastNameController.text
                                            ]);
                                            if (check) {
                                              accountProfileRequest.firstName =
                                                  Helper.capitalize(
                                                      _firstNameController
                                                          .text);
                                              accountProfileRequest.lastName =
                                                  Helper.capitalize(
                                                      _lastNameController.text);
                                              _changePage();
                                            } else {
                                              _showFailsMessage('Faltan campos por rellenar');
                                            }
                                            break;
                                          case 1:
                                            bool check = subContext
                                                .read<RegisterButtonCubit>()
                                                .checkData([
                                              _genderController.value,
                                            ]);
                                            if (check) {
                                              accountProfileRequest.genre =
                                              _genderController.value!;
                                              _changePage();
                                            } else {
                                              _showFailsMessage('Eliga una opcion para continuar');
                                            }
                                            break;
                                          case 2:
                                            bool check = subContext
                                                .read<RegisterButtonCubit>()
                                                .checkData([
                                              _phoneController.text,
                                              _emailController.text,
                                              _roleController.value
                                            ], false);
                                            if (check) {
                                              contextFather.read<
                                                  RegisterAuthCubit>()
                                                  .validateEmail(
                                                  _emailController.text);
                                            } else {
                                              _showFailsMessage('Faltan campos por rellenar');
                                            }
                                            break;
                                          case 3:
                                            bool check = subContext
                                                .read<RegisterButtonCubit>()
                                                .checkPassword(
                                                _passwordController.text,
                                                _passwordValController
                                                    .text);
                                            if (check) {
                                              accountProfileRequest.password =
                                                  _passwordController.text;
                                              contextFather.read<
                                                  RegisterAuthCubit>()
                                                  .validateAccount(
                                                  accountProfileRequest);
                                            } else {
                                              _showFailsMessage('Validador incorrecto');
                                            }
                                            break;
                                        }
                                        subContext
                                            .read<RegisterButtonCubit>()
                                            .selectView(_currentPage);
                                      },
                                    )));
                          } else {
                            return Container();
                          }
                        },
                        listener: (subContext, state) {
                          if (state is RegisterButtonError) {
                            FloatingWarningSnackBar.show(
                                subContext, state.errorSMS);
                          }
                        },
                      ))
                ],
              ));
        }));
  }
}
