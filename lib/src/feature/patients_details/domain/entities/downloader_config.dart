import 'package:flutter/material.dart';

class DownloaderConfig {
  bool addDoctorSign;
  bool addPatientDetails;
  final ValueNotifier<String?> followController;

  DownloaderConfig(this.addDoctorSign, this.addPatientDetails, this.followController);

  setDoctorSign(){
    addDoctorSign = !addDoctorSign;
  }

  setPatientDetails(){
    addPatientDetails = !addPatientDetails;
  }
}