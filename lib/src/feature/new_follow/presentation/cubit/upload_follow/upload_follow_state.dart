
import '../../../domain/entities/follow_case.dart';

abstract class UploadFollowState {}

class UploadFollowInitial extends UploadFollowState {}

class UploadFollowLoading extends UploadFollowState {}

class UploadFollowLoaded extends UploadFollowState {
  final FollowCase uploadFollow;
  UploadFollowLoaded(this.uploadFollow);
}

class UploadFollowPosted extends UploadFollowState {
  final FollowCase uploadFollow;
  UploadFollowPosted(this.uploadFollow);
}

class UploadFollowError extends UploadFollowState {
  final String errorSMS;
  UploadFollowError(this.errorSMS);
}

class UploadWithoutChanges extends UploadFollowError {
  UploadWithoutChanges(super.errorSMS);
}