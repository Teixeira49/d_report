

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/helpers.dart';

class DoctorHeaderTile extends StatelessWidget {

  const DoctorHeaderTile({super.key, required this.assignations});

  final int assignations;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: const Text("N° Doctores:"),
        tileColor: Theme.of(context).colorScheme.onPrimaryContainer,
        leading: Icon(
          Icons.numbers,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        trailing: Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
                color: Theme.of(context).colorScheme.primaryContainer,
                width: 2),
          ),
          child: Text(
            assignations < 100
                ? Helper.addZero(assignations)
                : assignations > 0
                ? '?' : 'M+',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 14),
          ),
        ));
  }


}