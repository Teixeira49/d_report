import 'assigned_doctor.dart';

class ViewDoctors {
  ViewDoctors({
    required this.assignedDoctors,
    required this.isCompleteAssignedDoctors,
    required this.countAssignedDoctors,
});

  List<AssignedDoctor> assignedDoctors;
  bool isCompleteAssignedDoctors;
  int countAssignedDoctors;

}