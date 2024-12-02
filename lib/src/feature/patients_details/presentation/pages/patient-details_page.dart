
import 'package:flutter/material.dart';

import '../../../main_page/domain/entities/patient.dart';
import '../widgets/headerWidget.dart';


class PatientDetailsPage extends StatelessWidget {

  //final String namePatient;

  const PatientDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    //double sizeIcon = size.shortestSide * 0.50;

    dynamic patient = ModalRoute.of(context)?.settings.arguments;
    Patient patientData = patient['data'];

    return Scaffold(

      appBar: AppBar(
        title: const Text("D_Project"),
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
                  HeaderWidget(context, patientData.getAllName(), patientData.getAge(), 'Emergency'),
                ]))
              ];
            },
            body: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(
                      text: "Resume",
                      icon: Icon(Icons.auto_stories)
                    ),
                    Tab(
                      text: "Taxonomy",
                      icon: Icon(Icons.biotech)
                    ),
                    Tab(
                      text: "Seguimiento",
                      icon: Icon(Icons.description)
                    ),
                  ],
                ),
                Expanded(
                    child: TabBarView(
                      children: [
                        Text("Resumen"),
                        Text("Taxonomia"),
                        Text("Seguimiento"),
                      ],
                    )
                )
              ],
            )
        ),
//        SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               minHeight: size.height * 0.25,
//             ),
//             child: const IntrinsicHeight(
//               child: Column(
//                 children: [
//                   D
//                   //Text("Pepe"),
//                 ]
//               )
//             )
//           )
//         )

      ),
    );
  }
}