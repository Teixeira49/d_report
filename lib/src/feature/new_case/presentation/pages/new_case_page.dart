import 'package:d_report/src/feature/new_patient/presentation/widgets/blood_type_field.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import '../../../profile_user/presentation/widgets/date_field.dart';
import '../widgets/data_textArea.dart';
import '../widgets/data_textfield.dart';
import '../widgets/finish_button.dart';
import '../widgets/floor_field.dart';

class NewCasePage extends StatelessWidget {
  const NewCasePage({super.key});

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
                    const SizedBox(height: 25,),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.010,
                        vertical: size.width * 0.020,
                      ),
                      child: Text(
                        "Porfavor complete la información del paciente",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      "Informacion del caso",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    CaseDataTextArea(contextRow: 'Nombre'),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.010,
                      ),
                      child: const CaseDataTextField(contextRow: 'Apelllido'),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.010,
                      ),
                      child: const CaseDataTextField(contextRow: 'CI Paciente'),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.010,
                      ),
                      child: const DateTextField(),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.075,
                          vertical: size.height * 0.010,
                        ),
                        child: Text(
                            "Area De internacion del paciente",
                            style: Theme.of(context).textTheme.titleMedium,
                        ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.010,
                      ),
                      child: FloorMixedField()
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.075,
                        vertical: size.height * 0.010,
                      ),
                      child: const CaseDataTextField(contextRow: 'CI Representante'),
                    ),
                    const SizedBox(height: 25,),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.010
                      ),
                      child: FinishRegisterCaseButton(),
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