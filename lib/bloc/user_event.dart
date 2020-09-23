part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUser extends UserEvent {
  final String id;

  LoadUser(this.id);

  @override
  List<Object> get props => [id];
}

class SignOut extends UserEvent {
    final User user;

  SignOut(this.user);
  @override
  List<Object> get props => [];

}

class UpdateData extends UserEvent {
  final String name;
  final String profileImage;
  final String phoneNumber;

  UpdateData({this.name, this.profileImage, this.phoneNumber});

  @override
  List<Object> get props => [name, profileImage];

}