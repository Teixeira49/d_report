import 'package:flutter/material.dart';

import '../widgets/button_tile.dart';

class PatientEditPageSelector extends StatelessWidget {
  const PatientEditPageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuracion del Caso'),
        centerTitle: false,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(24),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ButtonTile(
              titleOptionText: 'Paciente',
              descOptionText:
                  'Fecha de nacimiento, Lugar de Nacimiento, Cedula, Genero, Altura, Peso, Grupo Sanguineo.',
              iconData: Icons.person,
              route: 'patient',
            ),
            ButtonTile(
              titleOptionText: 'Representante',
              descOptionText: 'Cedula, Nro. Telefono, Direccion.',
              iconData: Icons.people,
              route: 'patient-guardian',
            ),
            ButtonTile(
              titleOptionText: 'Informacion del caso',
              descOptionText:
                  'Habitacion, Motivo de Consulta, Sintomatologia, Diagnostico Inicial, Area de Ingreso de Caso, Origen de Ingreso del paciente.',
              iconData: Icons.assignment,
              route: 'case',
            ),
            ButtonTile(
              titleOptionText: 'Cierre del caso',
              descOptionText: 'Razon de Cierre, Diagnostico Final.',
              iconData: Icons.assignment_turned_in,
              route: 'case-end',
            ),
          ],
        ),
      )),
    );
  }
}
