import 'package:d_report/src/shared/presentation/widget/bullet.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    int initial;
    try {
      dynamic arguments = ModalRoute
          .of(context)
          ?.settings
          .arguments;
      initial = arguments['id'] ?? 0;
    } catch (e) {
      initial = 0;
    }

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: PageView(
          controller: PageController(initialPage: initial),
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 24,),
                      Text(
                      'Felicidades, su cuenta ha sido creada Exitosamente:',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                      const Divider(height: 60,),
                      SizedBox(
                        height: 260,
                      child: Image.asset("assets/images/register/finish.png"),
                    ),
                        const Divider(height: 48,),

                        Container(margin: const EdgeInsets.symmetric(horizontal: 6),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BulletDecorator(
                              sizeBullet: 5,
                              marginHorizontal: 5,
                              marginVertical: 7.5),
                          SizedBox(width: 8,),
                          Expanded(child: Text(
                            'Recibira en la proximidad un correo para activar su usuario en cuanto nuestro equipo IT apruebe su identidad, aceptelo y inicie sesion en su dispositivo.',
                            textAlign: TextAlign.justify,
                          )),
                          SizedBox(width: 4,)
                        ],
                      )),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.only(bottom: 50, left: 24, right: 24),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: 45,
          child: MaterialButton(
            color: Theme
                .of(context)
                .colorScheme
                .primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0)),
            elevation: 10,
            focusColor: Theme
                .of(context)
                .colorScheme
                .inversePrimary,
            child: Text('Regresar',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme
                        .of(context)
                        .textTheme
                        .titleLarge
                        ?.color,
                    fontFamily:
                    Theme
                        .of(context)
                        .textTheme
                        .titleLarge
                        ?.fontFamily,
                    fontSize: 20)),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          )),
    );
  }
}
