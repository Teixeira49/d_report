class DownloaderConfig {
  bool addDoctorSign;
  bool addPatientDetails;

  DownloaderConfig(this.addDoctorSign, this.addPatientDetails);

  setDoctorSign(){
    addDoctorSign = !addDoctorSign;
  }

  setPatientDetails(){
    addPatientDetails = !addPatientDetails;
  }
}