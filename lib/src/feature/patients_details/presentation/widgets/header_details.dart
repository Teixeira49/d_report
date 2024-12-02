
import 'package:flutter/material.dart';

class HeaderDetails extends StatelessWidget {

  final context;
  final Size size;
  final String namePatient;
  final int agePatient;
  final String typeCase;

  const HeaderDetails(this.context, this.size, this.namePatient, this.agePatient, this.typeCase, {super.key});

  @override
  Widget build(BuildContext context) {

    var status = true;
    var p = status ? 'Active' : 'Close';

    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.015,
                horizontal: size.width * 0.05,
              ),
              child: Text('''Name: $namePatient
Age: $agePatient
Type Case: $typeCase
Status: $p''', textAlign: TextAlign.left, style: Theme.of(context).textTheme.bodyMedium,),
            )
          ]
    );
  }
}

