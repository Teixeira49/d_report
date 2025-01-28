
import '../../../../shared/data/model/profile_model.dart';
import '../../../../shared/domain/entities/doctor.dart';

class CompareProfilesUseCase {
  CompareProfilesUseCase();

  String? call(DoctorProfile originDoctor, DoctorProfile profileRequest) {
    dynamic originalDocJson = DoctorProfileModel.fromEntity(originDoctor).toJson();
    dynamic updateDocJson = DoctorProfileModel.fromEntity(profileRequest).toJson();

    String? error = 'Porfavor, realice modificaciones al Perfil.';

    List<String> profileRows = originalDocJson.keys.toList();

    for (var i in profileRows) {
      if (originalDocJson[i].toString().toLowerCase() !=
          updateDocJson[i].toString().toLowerCase()) {
        if (updateDocJson[i] == '') {
          error = 'Porfavor, no deje campos por rellenar.';
        } else {
          error = null;
        }
        break;
      }
    }
    return error;
  }
}
