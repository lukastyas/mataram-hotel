part of 'pages.dart';

class RoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Firestore firestore = Firestore.instance;
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return ListView(
      children: [
        //* HEADER
        Container(
          decoration: BoxDecoration(
              color: accentColor1,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                if (imageFileToUpluad != null) {
                  uploadImage(imageFileToUpluad).then((downloadURL) {
                    imageFileToUpluad = null;
                    context
                        .bloc<UserBloc>()
                        .add(UpdateData(profileImage: downloadURL));
                  });
                }
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.bloc<PageBloc>().add(GoToProfilePage());
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Color(0xFF5F5588), width: 1)),
                        child: Stack(
                          children: [
                            SpinKitCircle(
                              color: accentColor2,
                              size: 50,
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: (userState.user.profilePicture ==
                                              ""
                                          ? AssetImage("assets/user_pic.png")
                                          : NetworkImage(
                                              userState.user.profilePicture)),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              78,
                          child: Text(
                            userState.user.name,
                            style: whiteTextFont.copyWith(fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Text(
                          userState.user.email,
                          style: yellowNumberFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return SpinKitCircle(
                  color: accentColor2,
                  size: 50,
                );
              }
            },
          ),
        ),

        // TODO : HOTEL ROOM
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                context.bloc<PageBloc>().add(GoToSearchRoomPage());
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.7,
                height: MediaQuery.of(context).size.height / 3.3,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                margin: EdgeInsets.fromLTRB(25, 10, 20, 12),
                child: Center(
                  child: Text(
                    "Hotel Room",
                    style: blackTextFont.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.7,
              height: MediaQuery.of(context).size.height / 3.3,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: EdgeInsets.fromLTRB(25, 10, 20, 12),
              child: Center(
                child: Text(
                  "Meeting Room",
                  style: blackTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 16,
        ),

        ListTile(
            title: Text("Fasilitas"),
            subtitle: Container(
                // padding: EdgeInsets.all(2.0),
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 7,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ContentTile(
                        Icon(
                          Icons.wifi,
                          size: 16,
                        ),
                        'Free Wifi'),
                    ContentTile(
                        Icon(
                          Icons.tv,
                          size: 16,
                        ),
                        'Satelite Television'),
                    ContentTile(
                        Icon(
                          Icons.wifi,
                          size: 16,
                        ),
                        'Mineral Water'),
                    ContentTile(
                        Icon(
                          Icons.wifi,
                          size: 16,
                        ),
                        'Clean Linen'),
                    ContentTile(
                        Icon(
                          Icons.wifi,
                          size: 16,
                        ),
                        'Clean Washroom'),
                    ContentTile(
                        Icon(
                          Icons.wifi,
                          size: 16,
                        ),
                        'Toiletries'),
                  ],
                ))),
        ListTile(
            title: Text("Deskripsi Hotel"),
            subtitle: Container(
                // padding: EdgeInsets.all(2.0),
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 7,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text(
                  "Terletak di Yogyakarta dan berselang 500 meter dari Jalan Malioboro, Hotel Mataram 2 menawarkan kamar ber-AC dengan akses Wi-Fi gratis dan teras bergaya Jawa dengan pemandangan taman. Hotel juga menyediakan tempat parkir pribadi gratis di areanya.",
                  textAlign: TextAlign.justify,
                ))),
      ],
    );
  }
}
