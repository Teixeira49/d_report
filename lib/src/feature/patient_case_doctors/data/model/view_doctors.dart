import '../../domain/entities/assigned_doctor.dart';
import '../../domain/entities/view_doctors.dart';

class ViewDoctorsModel extends ViewDoctors {
  ViewDoctorsModel(
      {required super.assignedDoctors, required super.isCompleteAssignedDoctors, required super.countAssignedDoctors});

  factory ViewDoctorsModel.fromJson(json) {
    return ViewDoctorsModel(
        assignedDoctors: json['assignedDoctors'],
        isCompleteAssignedDoctors: json['isCompleteAssignedDoctors'],
        countAssignedDoctors: json['countAssignedDoctors']);
  }

  Map<String, dynamic> toJson() {
    return {
      'assignedDoctors': assignedDoctors,
      'isCompleteAssignedDoctors': isCompleteAssignedDoctors,
      'countAssignedDoctors': countAssignedDoctors,
    };
  }

  factory ViewDoctorsModel.fromEntity(ViewDoctors viewDoctors) {
    return ViewDoctorsModel(
      assignedDoctors: viewDoctors.assignedDoctors,
      isCompleteAssignedDoctors: viewDoctors.isCompleteAssignedDoctors,
      countAssignedDoctors: viewDoctors.countAssignedDoctors,
    );
  }

  factory ViewDoctorsModel.fromMixed(
      List<AssignedDoctor> assignedDoctors, json) {
    return ViewDoctorsModel(
      assignedDoctors: assignedDoctors,
      isCompleteAssignedDoctors: json['last'],
      countAssignedDoctors: json['totalElements'],
    );
  }
}
