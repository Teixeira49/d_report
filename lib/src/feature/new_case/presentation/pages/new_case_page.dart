import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';
import 'package:flutter/widgets.dart';

import '../widgets/data_textArea.dart';
import '../widgets/data_textfield.dart';
import '../widgets/entry_area_field.dart';
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
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.010,
                            vertical: size.width * 0.020,
                          ),
                          child: Text(
                            "Porfavor complete la información del paciente",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                    ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Informacion del caso",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.075,
                                vertical: size.height * 0.010,
                              ),
                              child: const CaseDataTextArea(contextRow: 'Sintomatologia'),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.075,
                                vertical: size.height * 0.010,
                              ),
                              child: const CaseDataTextArea(contextRow: 'Estado Fisico'),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.075,
                                vertical: size.height * 0.010,
                              ),
                              child: const CaseDataTextField(contextRow: 'Diagnostico Inicial'),
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
                              child: const EntryAreaDropdownField(),
                            ),
                          ],),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.010
                            ),
                            child: const FinishRegisterCaseButton(),
                          )
                        ]
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