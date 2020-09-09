part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  
  @override
  List<Object> get props => [];
}

class GoToRegistrationPage extends PageEvent {
  final RegistrationData registrationData;

  GoToRegistrationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrationData registrationData;

  GoToAccountConfirmationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class GoToProfilePage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToEditProfilePage extends PageEvent {
  final User user;

  GoToEditProfilePage(this.user);

  @override
  List<Object> get props => [user];
}

class GoToMyBookingPage extends PageEvent {
  final PageEvent pageEvent;

  GoToMyBookingPage(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];

}


class GoToSearchRoomPage extends PageEvent {
  final typeRoom;

  GoToSearchRoomPage(this.typeRoom);

  @override
  List<Object> get props => [];
}

class GotoDetailRoom extends PageEvent {
final RoomModel roomModel;

  GotoDetailRoom(this.roomModel);
  @override
  List<Object> get props => [];
}
class GotoBookDetail extends PageEvent {
final RoomModel roomModel;

  GotoBookDetail(this.roomModel);

  @override
  List<Object> get props => [];
}
class GotoTransferPage extends PageEvent {
final  wallet;
final RoomModel roomModel;

  GotoTransferPage({this.roomModel, this.wallet});

  @override
  List<Object> get props => [];
}
class GotoSendEvidence extends PageEvent {
      final RoomModel room;

  GotoSendEvidence(this.room);


  @override
  List<Object> get props => [];
}
class GotoCreateRoom extends PageEvent {

  @override
  List<Object> get props => [];
}