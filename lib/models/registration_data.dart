part of 'models.dart';

class RegistrationData {
  String name;
  String email;
  String password;
  File profileImage;
  String phoneNumber;

  RegistrationData(
      {this.name = "",
      this.email = "",
      this.password = "",
      this.phoneNumber = "",
      this.profileImage});
}
