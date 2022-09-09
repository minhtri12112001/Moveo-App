import '';
class UserModel{
  final String? userId;
  final String? userEmail;
  final String? userImage;
  final String? userName;
  final String? userAddress;
  final String? userRole;
  //UserModel(this.userId, this.userEmail, this.userName, this.userAddress);
  UserModel(this.userId, this.userEmail, this.userImage, this.userName, this.userAddress, this.userRole);

  UserModel.fromJson(Map<String, dynamic>? json)
  :     userId = json?['userId'],
        userEmail = json?['userEmail'],
        userImage = json?['userImage'],
        userName = json?['userName'],
        userAddress = json?['userAddress'],
        userRole = json?['userRole']
  ;

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userEmail': userEmail,
    'userImage': userImage,
    'userName': userName,
    'userAddress': userAddress,
    'userRole': userRole,
  };
}