import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/feature/auth/presentation/widgets/user_field.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class CurrentCasesPage extends StatelessWidget {

  final List<String> patients;

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
                child: ListTile(
                  title: Text(patients[index]),
                  subtitle: const Text('pepe'), //patients[index].getPrice()
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
                    Navigator.of(context).pushReplacementNamed('/patients/details/');
                  },
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}