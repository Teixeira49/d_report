import '../../../../shared/data/model/profile_model.dart';
import '../../../../shared/domain/entities/doctor.dart';

class CreateInstanceDoctorUserUseCase {

  CreateInstanceDoctorUserUseCase();

  DoctorProfile call(dynamic doctorJson) {
    return DoctorProfileModel.fromJson(doctorJson);
  }
}