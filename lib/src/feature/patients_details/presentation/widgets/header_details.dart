import 'package:d_report/src/core/helpers/helpers.dart';
import 'package:flutter/material.dart';

class HeaderDetails extends StatelessWidget {
  final context;
  final Size size;
  final String namePatient;
  final String agePatient;
  final String? status;

  const HeaderDetails(
      this.context, this.size, this.namePatient, this.agePatient, this.status,
      {super.key});

  @override
  Widget build(BuildContext context) {

    var age = Helper.getAgeByDateInString(agePatient);
    var caseStatus = status ?? "Activo";

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.015,
              horizontal: size.width * 0.05,
            ),
            child: Text(
              '''Age: $age
Status: $caseStatus''',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        ]);
  }
}
