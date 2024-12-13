import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    var temp = agePatient.split('T')[0];
    DateFormat time = DateFormat("yyyy-MM-dd");
    DateTime birthdayTemp = time.parse(temp);
    DateTime nowTemp = DateTime.now();

    var age = nowTemp.year - birthdayTemp.year;
    if (nowTemp.year - birthdayTemp.year <= 0 &&
        (nowTemp.month - birthdayTemp.month == 0 &&
            nowTemp.day - birthdayTemp.day < 0)) {
      age--;
    }
    print(age);
    print(birthdayTemp);

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
