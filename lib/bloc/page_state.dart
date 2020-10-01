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

class OnMainPageUser extends PageState {
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
  final List<BookModels> bookModels;
  final List<RoomModel> roomModel;
  final role;

  OnMyBookingPage(this.pageEvent, this.bookModels, this.roomModel, this.role);

  @override
  List<Object> get props => [pageEvent];
}
class OnScanPage extends PageState {
  final PageEvent pageEvent;

  OnScanPage(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];
}

class OnSearchRoomPage extends PageState {
  final typeRoom;

  OnSearchRoomPage(this.typeRoom);
  @override
  List<Object> get props => [];
}

class OnRoomDetailPage extends PageState {
  final RoomModel roomModel;

  OnRoomDetailPage(this.roomModel);

  @override
  List<Object> get props => [];
}

class OnBookDetailPage extends PageState {
  final RoomModel roomModel;
  final List<BookModels> bookModels;

  OnBookDetailPage(this.roomModel, this.bookModels);

  @override
  List<Object> get props => [];
}

class OnTransferPage extends PageState {
  final uid;
  final wallet;
  final idOrder;
  final RoomModel roomModel;

  OnTransferPage(
    this.idOrder,
    this.uid,
    this.wallet,
    this.roomModel,
  );

  @override
  List<Object> get props => [];
}

class OnSendEvidence extends PageState {
  final idOrder;
  final RoomModel roomModel;

  OnSendEvidence(this.idOrder, this.roomModel);

  @override
  List<Object> get props => [];
}

class OnCreateRoom extends PageState {
  @override
  List<Object> get props => [];
}

class OnBookingDetail extends PageState {
  final BookModels book;
  final PageEvent pageEvent;

  OnBookingDetail(this.book, this.pageEvent);

  @override
  List<Object> get props => [];
}
class OnNewestPage extends PageState {
  final List<BookModels> book;

  OnNewestPage(this.book, );

  @override
  List<Object> get props => [];
}
class OnNewestPageGlobal extends PageState {
 
  @override
  List<Object> get props => [];
}
