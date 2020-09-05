part of 'extensions.dart';

extension FirebaseUserExtension on FirebaseUser {
  User convertToUser({String name = "No Name", String phoneNumber}) =>
      User(this.uid, this.email, name: name, phoneNumber: phoneNumber);

  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
}
