import '../../../core/utils/constants/fields_constants.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.userName,
    required super.userEmail,
    required super.userRoleUid,
    required super.userImgUrl,
    required super.userProfileId,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      userName: json['docFirstName'] + space + json['docLastName'],
      userEmail: json['userEmail'],
      userRoleUid: json['uid'],
      userImgUrl: json['docPhotoUrl'] ?? "",
      userProfileId: json['docId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'userRole': userRoleUid,
      'userImgUrl': userImgUrl,
      'userProfileId': userProfileId
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      userName: user.userName,
      userEmail: user.userEmail,
      userRoleUid: user.userRoleUid,
      userImgUrl: user.userImgUrl,
      userProfileId: user.userProfileId,
    );
  }
}
