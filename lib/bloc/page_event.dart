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

class GoToMainPageUser extends PageEvent {
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
  final role;

  GoToMyBookingPage(this.pageEvent, this.role);

  @override
  List<Object> get props => [pageEvent];
}

class GotoScanPage extends PageEvent {
  final PageEvent pageEvent;

  GotoScanPage(
    this.pageEvent,
  );

  @override
  List<Object> get props => [pageEvent];
}

class GotoNewestPage extends PageEvent {
  @override
  List<Object> get props => [];
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
final FirebaseUser firebaseUser ;

  GotoBookDetail(this.roomModel, this.firebaseUser);

  @override
  List<Object> get props => [];
}

class GotoTransferPage extends PageEvent {
  final wallet;
  final uid;
  final selecetedDateFrom;
  final selecetedDateTo;
  final idOrder;
  final totalNight;
  final startEvent;
  final room;
  final bool back;
  final RoomModel roomModel;

  GotoTransferPage(
      {this.totalNight,
      this.room,
      this.idOrder,
      this.startEvent,
      this.uid,
      this.back,
      this.selecetedDateFrom,
      this.selecetedDateTo,
      this.roomModel,
      this.wallet});

  @override
  List<Object> get props => [];
}

class GotoSendEvidence extends PageEvent {
  final RoomModel room;
  final idOrder;
  final wallet;
  GotoSendEvidence(this.room, this.idOrder, this.wallet);

  @override
  List<Object> get props => [];
}

class GotoCreateRoom extends PageEvent {
  @override
  List<Object> get props => [];
}

class GotoEditRoom extends PageEvent {
  final RoomModel room;

  GotoEditRoom(this.room);
  @override
  List<Object> get props => [];
}

class GotoNewest extends PageEvent {
  @override
  List<Object> get props => [];
}

class GotoBookingDetail extends PageEvent {
  final BookModels book;
  final PageEvent pageEvent;

  GotoBookingDetail(this.book, this.pageEvent);

  @override
  List<Object> get props => [];
}

class GoToContactUsPage extends PageEvent {
  @override
  List<Object> get props => [];
}
