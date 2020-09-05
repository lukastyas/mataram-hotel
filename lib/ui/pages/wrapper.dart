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
                                    ? MyBookingPage(pageState.pageEvent)
                                    : (pageState is OnSearchRoomPage)
                                        ? SearchRoom()
                                        : (pageState is OnRoomDetailPage)
                                            ? RoomDetail(room: pageState.roomModel,)
                                            : MainPage());
  }
}
