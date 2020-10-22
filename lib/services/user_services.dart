part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static Future<void> updateUser(User user, {token}) async {
    _userCollection.document(user.id).setData({
      'email': user.email,
      'name': user.name,
      'role': user.role??0,
      'phoneNumber': user.phoneNumber,
      'profilePicture': user.profilePicture ?? "",
      'fcm_token': token
    });
  }

  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.document(id).get();
    return User(id, snapshot.data['email'],
        name: snapshot.data['name'],
        role: snapshot.data['role'],
        fcmToken: snapshot.data['fcm_token'],
        phoneNumber: snapshot.data['phoneNumber'],
        profilePicture: snapshot.data['profilePicture']);
  }
}
