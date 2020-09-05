import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mataram2/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  PageState get initialState => OnInitialPage();

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToSplashPage) {
      yield OnSplashPage();
    } else if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToMainPage) {
      yield OnMainPage();
    } else if (event is GoToRegistrationPage) {
      yield OnRegistrationPage(event.registrationData);
    } else if (event is GoToAccountConfirmationPage) {
      yield OnAccountConfirmationPage(event.registrationData);
    } else if (event is GoToProfilePage) {
      yield OnProfilePage();
    } else if (event is GoToEditProfilePage) {
      yield OnEditProfilePage(event.user);
    } 
    else if (event is GoToMyBookingPage) {
      yield OnMyBookingPage(event.pageEvent);
    }
    else if (event is GoToSearchRoomPage) {
      yield OnSearchRoomPage();
    }
    else if (event is GotoDetailRoom) {
      yield OnRoomDetailPage(event.roomModel);
    }
  }
}
