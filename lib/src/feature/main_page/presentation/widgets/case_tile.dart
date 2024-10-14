import 'dart:ui';

import 'package:d_report/src/feature/main_page/domain/entities/patient.dart';
import 'package:flutter/material.dart';

class CaseTile extends StatelessWidget {

  final context;
  final Patient dataPatient;

  const CaseTile(this.context, this.dataPatient, {super.key});

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Text(
        dataPatient.getAllName(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        dataPatient.getMessage(),
        style: const TextStyle(fontStyle: FontStyle.italic),
      ),
      tileColor: const Color.fromRGBO(210, 233, 245, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.5)
      ),
      trailing: const Icon(
        Icons.arrow_circle_right, color: Colors.grey,
      ),
      leading: const Icon(
        Icons.person_search_outlined, color: Colors.grey,
      ),
      onTap: () {
        Navigator.of(context).pushNamed('/patients/details/',
            arguments: {"data":dataPatient}
        );
      },
    );
  }
}