import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/doctor.dart';

abstract class ProfileRepository {

  Future<Either<Failure, Doctor>> getDoctorProfileById(int docId, String accessToken);

}

