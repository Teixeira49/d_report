import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import '../widgets/data_textfield.dart';
import '../widgets/next_state_button.dart';

class FindPatientPage extends StatelessWidget {
  const FindPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          caseDetails,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                    const SizedBox(height: 25,),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.010,
                          vertical: size.width * 0.020,
                        ),
                        child: Text(
                          "Buscar paciente ya registrado",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1,
                                vertical: size.height * 0.010,
                              ),
                              child: Text(
                                "Ingrese documento de identidad del representante / paciente y su nombre.",
                                textAlign: TextAlign.justify,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.075,
                                vertical: size.height * 0.010,
                              ),
                              child: const PatientDataTextField(contextRow: 'Sintomatologia'),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.075,
                                vertical: size.height * 0.010,
                              ),
                              child: const PatientDataTextField(contextRow: 'Estado Fisico'),
                            ),
                          ],
                        )
                    ),
                    const SizedBox(height: 25,),
                    Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.010
                              ),
                              child: NextStateButton(),
                            )
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}