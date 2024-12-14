import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/card_patient_summary.dart';
import '../widgets/data_textArea.dart';
import '../widgets/end_case_status.dart';

class EndCasePage extends StatefulWidget {
  const EndCasePage({super.key});

  @override
  MyEndCasePage createState() => MyEndCasePage();
}

class MyEndCasePage extends State<EndCasePage> {
  final TextEditingController _endDiagnosisData = TextEditingController();
  final ValueNotifier<String?> _endStatusController = ValueNotifier(null);

  @override
  void dispose() {
    _endDiagnosisData.dispose();
    _endStatusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fin del caso'),
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [Text('Paciente'), Spacer(), Text('Jose    ')],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  Text('Estatus final'),
                  Spacer(),
                  Flexible(
                      child: StatusField(
                    controllerDataDropDown: _endStatusController,
                  ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text('Diagnostico'),
            ),
            Container(
                child: CaseDataTextArea(
              contextRow: 'Diagnostico Final',
              controllerData: _endDiagnosisData,
            )),
            Container(
              padding: EdgeInsets.symmetric(
               vertical: 20,
                horizontal: 40
              ),
              child: Text( "Utilice este espacio para narrar el final del caso, y describir el padecimiento que realmente tenia el paciente", textAlign: TextAlign.justify,)
            ),
            Spacer(),
            TextButton(onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            }
                , child: Text('Finalizar')),
          ],
        ),
      ),
    );
  }
}
