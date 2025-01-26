import 'dart:ui';

import 'package:d_report/my_flutter_app_icons.dart';
import 'package:d_report/src/shared/presentation/widget/bullet.dart';
import 'package:flutter/material.dart';

class HeaderDetails extends StatelessWidget {
  final BuildContext fatherContext;
  final String? status;
  final dynamic arguments;

  const HeaderDetails(this.fatherContext, this.status, {super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    var caseStatus = status ?? "Activo";

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.assignment, size: 22),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Estatus del Caso:',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      caseStatus,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    BulletDecorator(
                      sizeBullet: 17,
                      marginHorizontal: 0,
                      marginVertical: 0,
                      gradientSystem: caseStatus == "Activo"
                          ? [
                              Colors.green,
                              Colors.lightGreen,
                              Colors.lightGreenAccent,
                              Colors.limeAccent,
                            ]
                          : [
                              Colors.pink,
                              Colors.red,
                              Colors.amber,
                            ],
                      shadowSystem: [
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.2),
                          spreadRadius: 2.8,
                          blurRadius: 6,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(MyFlutterApp.user_md, size: 22),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Doctores en el caso:',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  MaterialButton(
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      elevation: 10,
                      onPressed: () {
                        Navigator.of(fatherContext).pushNamed(
                            '/main/patients/details/doctors',
                            arguments: arguments);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '6',
                            // poner condicion de que si son mas de 99 salga M+
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.remove_red_eye,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        ],
                      ))
                ],
              )),
        ]);
  }
}
