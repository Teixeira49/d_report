import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import '../widgets/data_textArea.dart';
import '../widgets/data_textfield.dart';
import '../widgets/next_state_button.dart';

class NewFollowCasePage extends StatelessWidget {
  const NewFollowCasePage({super.key});

  //final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Center(
          child: SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height * 0.25,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            'Agregar Seguimiento',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.040,
                            vertical: size.height * 0.010,
                          ),
                          child: CaseDataTextField(
                              contextRow: "Titulo del Seguimiento"),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.040,
                            vertical: size.height * 0.010,
                          ),
                          child: CaseDataTextArea(
                              contextRow: "Informacion del Seguimiento"),
                        ),
                        SizedBox(height: 10,),
                        Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.080,
                              vertical: size.height * 0.010,
                            ),
                            child: Text(
                              'Utilice este espacio para agregar un reporte de observaciones de como a visto la evolucion sintomatologica del paciente.',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.justify,
                            )),
                        SizedBox(height: 10,),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.010),
                              child: const NextStateButton(),
                            )
                          ],
                        ))
                      ],
                    ),
                  ))),
        ));
  }
}
