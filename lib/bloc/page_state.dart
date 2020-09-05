part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnInitialPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnLoginPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnMainPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnRegistrationPage extends PageState {
  final RegistrationData registrationData;

  OnRegistrationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class OnAccountConfirmationPage extends PageState {
  final RegistrationData registrationData;

  OnAccountConfirmationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class OnProfilePage extends PageState {
  @override
  List<Object> get props => [];
}

class OnEditProfilePage extends PageState {
  final User user;

  OnEditProfilePage(this.user);

  @override
  List<Object> get props => [user];
}

class OnMyBookingPage extends PageState {
  final PageEvent pageEvent;

  OnMyBookingPage(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];

}

class OnSearchRoomPage extends PageState {
  @override
  List<Object> get props => [];

}
class OnRoomDetailPage extends PageState {
  final RoomModel roomModel;

  OnRoomDetailPage(this.roomModel);

  @override
  List<Object> get props => [];

}
