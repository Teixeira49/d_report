import '../../domain/entities/assigned_doctor.dart';
import '../../domain/entities/view_doctors.dart';

class ViewDoctorsModel extends ViewDoctors {
  ViewDoctorsModel(
      {required super.assignedDoctors, required super.countAssignedDoctors});

  factory ViewDoctorsModel.fromJson(json) {
    return ViewDoctorsModel(
        assignedDoctors: json['assignedDoctors'],
        countAssignedDoctors: json['countAssignedDoctors']);
  }

  Map<String, dynamic> toJson() {
    return {
      'assignedDoctors': assignedDoctors,
      'countAssignedDoctors': countAssignedDoctors,
    };
  }

  factory ViewDoctorsModel.fromEntity(ViewDoctors viewDoctors) {
    return ViewDoctorsModel(
      assignedDoctors: viewDoctors.assignedDoctors,
      countAssignedDoctors: viewDoctors.countAssignedDoctors,
    );
  }

  factory ViewDoctorsModel.fromMixed(
      List<AssignedDoctor> assignedDoctors, int count) {
    return ViewDoctorsModel(
      assignedDoctors: assignedDoctors,
      countAssignedDoctors: count,
    );
  }
}
