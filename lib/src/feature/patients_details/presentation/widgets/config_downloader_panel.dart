import 'package:d_report/src/feature/patients_details/domain/entities/downloader_config.dart';
import 'package:flutter/material.dart';
import 'config_follow_adder_selector.dart';
import 'config_switch.dart';

void configDownloaderPanel(BuildContext context,
    DownloaderConfig downloaderConfig, Function function) {
  showDialog(
    context: context,
    builder: (BuildContext subContextDialog) => AlertDialog(
      title: const Text("Descargar Informe"),
      backgroundColor: Theme.of(subContextDialog).scaffoldBackgroundColor,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Detalles del Paciente'),
              ConfigSwitch(
                configVar: downloaderConfig.addPatientDetails,
                onChanged: (newValue) {
                  downloaderConfig.setPatientDetails();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Firma del Doctor'),
              ConfigSwitch(
                configVar: downloaderConfig.addDoctorSign,
                onChanged: (newValue) {
                  downloaderConfig.setDoctorSign();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Agregar Seguimiento:'),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: ConfigFollowAdderSelector(
                  controllerDataDropDown: downloaderConfig.followController,
                ),
              )
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(subContextDialog);
            },
            child: Text(
              'Cancelar',
              style: TextStyle(
                  color: Theme.of(subContextDialog).colorScheme.secondary),
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(subContextDialog);
              function();
            },
            child: Text('Confirmar'))
      ],
    ),
  );
}
