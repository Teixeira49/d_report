import 'package:d_report/src/feature/main_page/domain/entities/patient.dart';
import 'package:flutter/material.dart';
import 'case_tile.dart';

class CurrentCasesPage extends StatelessWidget {

  final List<Patient> patients;

  const CurrentCasesPage(this.patients, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return Center(
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: patients.length,
              itemBuilder: ((context, index) =>
              Card(
                color: const Color.fromRGBO(210, 233, 245, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.5)
                ),
                child: CaseTile(context, patients[index])
              )),
            ),
          ),
        ],
      ),
    );
  }
}