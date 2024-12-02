
import 'package:flutter/material.dart';

import '../../../main_page/domain/entities/patient.dart';
import '../widgets/card_patient_data.dart';
import '../widgets/card_patient_summary.dart';
import '../widgets/follow_tile.dart';
import '../widgets/header_details.dart';


class PatientDetailsPage extends StatelessWidget {

  //final String namePatient;


  const PatientDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    //double sizeIcon = size.shortestSide * 0.50;

    dynamic patient = ModalRoute.of(context)?.settings.arguments;
    List<String> pepe = ['pepe', 'e'];
    Patient patientData = patient['data'];

    final size = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Detalles del Caso"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return  [
                SliverList(delegate:  SliverChildListDelegate([
                  HeaderDetails(
                      context,
                      size,
                      patientData.getAllName(),
                      patientData.getAge(),
                      'Emergency'
                  ),
                ]))
              ];
            },
            body: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(
                        text: "Paciente",
                        icon: Icon(Icons.person)
                    ),
                    Tab(
                      text: "Resumen",
                      icon: Icon(Icons.library_books) //auto_stories
                    ),
                    Tab(
                      text: "Seguimiento",
                      icon: Icon(Icons.medication)
                    ),
                    //Tab(
                    //  text: "Seguimiento", Ordenes
                    //  icon: Icon(Icons.biotech) biotech
                    //),
                  ],
                ),
                Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 10,),
                                CustomCardPatientRow(
                                  widgetKey: "Fecha de Nacimiento",
                                  widgetValue: '25-11-2007',
                                  tileIcon: Icons.calendar_month,
                                ),
                                CustomCardPatientRow(
                                  widgetKey: "Doc Identidad",
                                  widgetValue: '123124124',
                                  tileIcon: Icons.perm_identity,
                                ),
                                CustomCardPatientRow(
                                  widgetKey: "Doc Identidad Representante",
                                  widgetValue: '12312412',
                                  tileIcon: Icons.family_restroom,
                                ),
                                CustomCardPatientRow(
                                  widgetKey: "Genero",
                                  widgetValue: 'Hombre',
                                  tileIcon: Icons.male,
                                ),
                                CustomCardPatientRow(
                                  widgetKey: "Tipo de Sangre",
                                  widgetValue: 'Grupo A+',
                                  tileIcon: Icons.water_drop,
                                ),
                              ]
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomCardResumeRow(
                                widgetKey: "Habitacion",
                                widgetValue: 'A3 - 302',
                              ),
                              CustomCardResumeRow(
                                widgetKey: "Fecha de Ingreso",
                                widgetValue: 'Grupo A+',
                              ),
                              CustomCardResumeRow(
                                widgetKey: "Sintomatologia",
                                widgetValue: 'Grupo A+',
                              ),
                              CustomCardResumeRow(
                                widgetKey: "Diagnostico inicial",
                                widgetValue: 'MuchoTexto',
                              ),
                              CustomCardResumeRow(
                                widgetKey: "Fecha Fin del Caso",
                                widgetValue: 'Grupo A+',
                              ),
                              CustomCardResumeRow(
                                widgetKey: "Diagnostico final",
                                widgetValue: 'Grupo A+',
                              ),
                            ],
                          )
                        ),
                        //Text("Taxonomia"),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 5,),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.075,
                                  vertical: size.height * 0.010,
                                ),
                                child: TextField(

                                ),
                              ),
                              ListView.builder(
                                itemCount: pepe.length,
                                shrinkWrap: true,
                                itemBuilder: (
                                        (context, index) => FollowTile(context, 'a')
                                )
                            )
                            ]
                          )
                        )
                      ],
                    )
                )
              ],
            )
        ),
      ),
    );
  }
}