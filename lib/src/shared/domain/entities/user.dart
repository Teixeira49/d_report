
class  User  {
  final String userName;
  final String userEmail;
  final int userRoleUid;
  final String userImgUrl;
  final int userProfileId;

  User(
        {
          required  this .userName,
          required  this .userEmail,
          required  this .userRoleUid,
          required  this .userImgUrl,
          required  this .userProfileId,
        }
      );

  String getImg(){
    return userImgUrl;
  }
}