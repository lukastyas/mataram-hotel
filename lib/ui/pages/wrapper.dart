part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnLoginPage)
                ? SignInPage()
                : (pageState is OnRegistrationPage)
                    ? SignUpPage(pageState.registrationData)
                    : (pageState is OnAccountConfirmationPage)
                        ? AccountConfirmationPage(pageState.registrationData)
                        : (pageState is OnProfilePage)
                            ? ProfilePage()
                            : (pageState is OnEditProfilePage)
                                ? EditProfilePage(pageState.user)
                                : (pageState is OnMyBookingPage)
                                    ? MyBookingPage(pageState.bookModels,
                                        pageState.pageEvent, pageState.role, pageState.roomModel)
                                    : (pageState is OnSearchRoomPage)
                                        ? SearchRoom(
                                            typeRoom: pageState.typeRoom)
                                        : 
                                        (pageState is OnRoomDetailPage)
                                            ? RoomDetail(
                                                room: pageState.roomModel,
                                              ):
                                      (pageState is OnBookDetailPage)
                                                ? BookDetail(firebaseUser.uid,
                                                    pageState.roomModel)
                                                : (pageState is OnTransferPage)
                                                    ? TransferPage(
                                                        pageState.idOrder,
                                                        wallet:
                                                            pageState.wallet,
                                                        room:
                                                            pageState.roomModel,
                                                      )
                                                    : (pageState
                                                            is OnSendEvidence)
                                                        ? SendEvidencePage(
                                                            idOrder: pageState
                                                                .idOrder,
                                                            room: pageState
                                                                .roomModel,
                                                                wallet: pageState.wallet,
                                                          )
                                                        : (pageState
                                                                is OnBookingDetail)
                                                            ? BookingDetail(
                                                                book: pageState
                                                                    .book,
                                                                pageEvent:
                                                                    pageState
                                                                        .pageEvent,
                                                              )
                                                        : (pageState
                                                                is OnEditRoom)
                                                            ? EditProfile(
                                                                room: pageState
                                                                    .room,
                                                                    edit : true
                                                              )
                                                            : (pageState
                                                                    is OnScanPage)
                                                                ? ScanQRPage()
                                                                : (pageState
                                                                        is OnCreateRoom)
                                                                    ? CreateRoom()
                                                                : (pageState
                                                                        is OnNewestPageGlobal)
                                                                    ? Newest()
                                                                    : MainPage());
  }
}
