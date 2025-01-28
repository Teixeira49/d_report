import '../../../../shared/data/model/profile_model.dart';
import '../../../../shared/domain/entities/doctor.dart';
import '../../data/models/profile_doctor_request_model.dart';
import '../entities/profile_doctor_request.dart';

class CreateInstanceProfileUserRequestUseCase {

  CreateInstanceProfileUserRequestUseCase();

  DoctorProfileRequest call(DoctorProfile doctorProfile) {
    dynamic doctorJson = DoctorProfileModel.fromEntity(doctorProfile).toJson();
    return DoctorProfileRequestModel.fromJson(doctorJson);
  }
}