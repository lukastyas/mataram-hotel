part of 'models.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final String phoneNumber;

  User(this.id, this.email, {this.name, this.profilePicture, this.phoneNumber});

  User copyWith({String name, String profilePicture, String phoneNumber}) =>
      User(this.id, this.email,
          name: name ?? this.name,
          profilePicture: profilePicture ?? this.profilePicture,
          phoneNumber: phoneNumber ?? this.phoneNumber);

  @override
  String toString() {
    return "[$id] - $name, $email";
  }

  @override
  List<Object> get props => [id, email, name, profilePicture, phoneNumber];
}
