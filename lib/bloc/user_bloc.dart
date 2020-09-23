import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mataram2/models/models.dart';
import 'package:mataram2/services/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
      SharedPreferences pref = await SharedPreferences.getInstance();
      var fcmToken;

      _firebaseMessaging.getToken().then((token) {
        print(token);
        pref.setString('fcmToken', token);
        fcmToken = token;
      });

      User user = await UserServices.getUser(event.id);

      await UserServices.updateUser(user, token: fcmToken);

      yield UserLoaded(user);
    } else if (event is SignOut) {
      await UserServices.updateUser(event.user, token: "");

      yield UserInitial();
    } else if (event is UpdateData) {
      User updateUser = (state as UserLoaded).user.copyWith(
          name: event.name,
          profilePicture: event.profileImage,
          phoneNumber: event.phoneNumber);

      await UserServices.updateUser(updateUser);

      yield UserLoaded(updateUser);
    }
  }
}
