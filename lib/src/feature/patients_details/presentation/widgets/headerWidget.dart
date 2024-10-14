
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {

  final context;
  final String namePatient;
  final int agePatient;
  final String typeCase;

  const HeaderWidget(this.context, this.namePatient, this.agePatient, this.typeCase, {super.key});

  @override
  Widget build(BuildContext context) {

    var status = true;
    var p = status ? 'Active' : 'Close';

    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(15),
              child: Text('''Name: $namePatient
Age: $agePatient
Type Case: $typeCase
Status: $p''', textAlign: TextAlign.left),
            )
          ]
    );
  }
}

