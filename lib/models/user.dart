part of 'models.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final String phoneNumber;
  final String fcmToken;
  final int role;

  User(this.id, this.email,   {this.fcmToken,this.role,this.name, this.profilePicture, this.phoneNumber});

  User copyWith({String name, String profilePicture, String phoneNumber}) =>
      User(this.id, this.email,
          name: name ?? this.name,
          fcmToken: fcmToken ?? this.fcmToken,
          role: role ?? this.role,
          profilePicture: profilePicture ?? this.profilePicture,
          phoneNumber: phoneNumber ?? this.phoneNumber);

  @override
  String toString() {
    return "[$id] - $name, $email";
  }

  @override
  List<Object> get props => [id, email,  fcmToken,role, name, profilePicture, phoneNumber];
}
