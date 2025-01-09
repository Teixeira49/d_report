import 'package:flutter/material.dart';
import '../../domain/entities/downloader_config.dart';
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
              const Text('Detalles del Paciente'),
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
              const Text('Firma del Doctor'),
              ConfigSwitch(
                configVar: downloaderConfig.addDoctorSign,
                onChanged: (newValue) {
                  downloaderConfig.setDoctorSign();
                },
              ),
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
