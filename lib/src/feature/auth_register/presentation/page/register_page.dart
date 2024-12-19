import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import 'package:d_report/src/feature/auth_register/presentation/widgets/lastname_field.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../domain/entities/gender.dart';
import '../widgets/firstname_field.dart';
import '../../../auth/presentation/widgets/password_field.dart';
import '../widgets/gender_selector.dart';
import '../widgets/register_button.dart';
import '../widgets/type-user_field.dart';
import '../../../auth/presentation/widgets/user_field.dart';
import '../widgets/validate-password_field.dart';

final _formatKey2 = GlobalKey<FormState>();

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  MyRegisterPageState createState() => MyRegisterPageState();
}

class MyRegisterPageState extends State<RegisterPage> {
  // Agregar Para telefono tambien

  // Agregar rol al que aplica con botones como los de arriba

  // Agregar una lista de Especialidades, con un Otros

  List<Gender> genders = [
    Gender("Male", Icons.male, false),
    Gender("Female", Icons.female, false),
    Gender("Others", Icons.circle_outlined, false)
  ];

  int _currentPage = 0;
  bool _keyboardVisible = false;
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    //KeyboardVisibilityNotification().onKeyboardChanged = (isKeyboardVisible) {
    //  setState(() {
    //    _keyboardVisible = isKeyboardVisible;
    //  });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (_currentPage > 0) {
                  setState(() {
                    _currentPage--;
                    _controller.animateToPage(_currentPage,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  });
                  print(_currentPage);
                } else if (_currentPage == 0) {
                  Navigator.pop(context);
                  print('object');
                }
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            registerData + space + user,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          actions: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 4, // Número total de páginas
                  effect: JumpingDotEffect(
                    activeDotColor: Theme.of(context).primaryColor,
                    dotHeight: 12,
                    dotWidth: 12,
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
                                                horizontal: size.width * 0.075,
                                                vertical: size.height * 0.020,
                                              ),
                                              child: Text(
                                                'Registro del Usuario',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
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
                                          horizontal: size.width * 0.075,
                                          vertical: size.height * 0.015,
                                        ),
                                        child: const FirstNameTextField()),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.075,
                                          vertical: size.height * 0.015,
                                        ),
                                        child: const LastNameTextField()),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.1,
                                            vertical: size.height * 0.020,
                                          ),
                                          child: Text(
                                            'Porfavor ingrese su nombre y apellido para que otros usuarios puedan conocerlo.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Theme.of(context)
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 220,
                        child: Image.asset("assets/images/register/gender.png"),
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
                              itemBuilder: (subContext, indexSelector) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      genders.forEach((gender) =>
                                          gender.isSelected = false);
                                      genders[indexSelector].isSelected = true;
                                    });
                                  },
                                  child: CustomRadio(genders[indexSelector]),
                                );
                              })),
                      SizedBox(
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
                              color: Theme.of(context)
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.075,
                                    vertical: size.height * 0.025,
                                  ),
                                  child: Text(
                                    'Cuenta del Usuario',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 220,
                                  child: Image.asset("assets/images/register/profile.png"),
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.075,
                                      vertical: size.height * 0.025,
                                    ),
                                    child: const TypeUserDropdownField()),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.075,
                                      vertical: size.height * 0.025,
                                    ),
                                    child: UserAccountTextField(
                                      controllerData: _emailController,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.075,
                                    vertical: size.height * 0.025,
                                  ),
                                  child: Text(
                                    'Contraseña',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 220,
                                  child: Image.asset("assets/images/register/security.png"),
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.075,
                                      vertical: size.height * 0.025,
                                    ),
                                    child: PasswordTextField(
                                      password: password,
                                      controllerData: _passwordController,
                                    )),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.075,
                                      vertical: size.height * 0.025,
                                    ),
                                    child: PasswordTextField(
                                      password: password,
                                      controllerData: _passwordController,
                                    )),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: size.height / 60, bottom: 0.25),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ]),
            Positioned(
              bottom: 50,
              child: OutlinedButton(
                  onPressed: () {
                    //setState(() {
                    _currentPage++;
                    _controller.animateToPage(_currentPage,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                    //});
                    print(_currentPage);
                  },
                  child: const Text("Click to load data")),
            )
          ],
        ));
  }
}
