import 'package:d_report/src/feature/new_patient/presentation/widgets/blood_type_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:d_report/src/core/utils/constants/fields_constants.dart';

import '../../../profile_user/presentation/widgets/date_field.dart';
import '../../../profile_user/presentation/widgets/genre-user_field.dart';
import '../widgets/data_textfield.dart';
import '../widgets/next_state_button.dart';

class NewPatientPage extends StatelessWidget {
  const NewPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          registerData + space + patient,
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
                     Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: const PatientDataTextField(contextRow: 'Nombre'),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: const PatientDataTextField(contextRow: 'Apelllido'),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: const PatientDataTextField(contextRow: 'CI Paciente'),
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
                            child: const Row(
                              children: [
                                Expanded(child: TypeGenreDropdownField()),
                                SizedBox(width: 10,),
                                Expanded(child: TypeBloodDropdownField())
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.075,
                              vertical: size.height * 0.010,
                            ),
                            child: const PatientDataTextField(contextRow: 'CI Representante'),
                          ),
                        ],
                      ),
                    const SizedBox(height: 25,),
                    Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
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