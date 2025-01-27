import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/auth_user.dart';
import '../widgets/button_tile.dart';

class PatientEditPageSelector extends StatelessWidget {
  const PatientEditPageSelector({super.key});

  @override
  Widget build(BuildContext context) {

    dynamic arguments =
        ModalRoute.of(context)?.settings.arguments; // TODO Refactor Rename

    AuthUser authUser = arguments["AuthCredentials"]; // TODO Rename

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuracion del Caso'),
        centerTitle: false,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(24), // TODO CREATE CONSTANT
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Visibility(
              visible: authUser.roleId == 3,
                child: ButtonTile(
                  titleOptionText: 'Nombre del Paciente',
                  descOptionText:
                  'Nombre, Apellido.',
                  iconData: Icons.person,
                  route: 'patient',
                  arguments: arguments,
                  getIndex: 0,
                ),
            ),
            ButtonTile(
              titleOptionText: 'Paciente',
              descOptionText:
                  'Fecha de nacimiento, Lugar de Nacimiento, Cedula, Genero, Altura, Peso, Grupo Sanguineo.',
              iconData: Icons.person,
              route: 'patient',
              arguments: arguments,
              getIndex: 1,
            ),
            ButtonTile(
              titleOptionText: 'Representante',
              descOptionText: 'Cedula, Nro. Telefono, Direccion.',
              iconData: Icons.people,
              route: 'patient-guardian',
              arguments: arguments,
            ),
            ButtonTile(
              titleOptionText: 'Informacion del Caso',
              descOptionText:
                  'Motivo de Consulta, Sintomatologia, Estado Fisico, Diagnostico Inicial.',
              iconData: Icons.assignment,
              route: 'case',
              arguments: arguments,
              getIndex: 0,
            ),
            ButtonTile(
              titleOptionText: 'Area de Ingreso',
              descOptionText:
              'Habitacion, Area de Ingreso de Caso, Origen de Ingreso del paciente.',
              iconData: Icons.door_front_door,
              route: 'case',
              arguments: arguments,
              getIndex: 1,
            ),
            Visibility(
              visible: authUser.roleId == 3 || arguments['casKey']['casEndFlag'] == true,
                child: ButtonTile(
                  titleOptionText: 'Cierre del Caso',
                  descOptionText: 'Razon de Cierre, Diagnostico Final.',
                  iconData: Icons.assignment_turned_in,
                  route: 'case',
                  arguments: arguments,
                  getIndex: 2,
                ),
            ),
          ],
        ),
      )),
    );
  }
}
