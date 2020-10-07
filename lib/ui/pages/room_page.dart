part of 'pages.dart';

class RoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<SearchRoomBloc>().add(LoadRoom(admin: true));

    // final Firestore firestore = Firestore.instance;
    // MediaQueryData mediaQueryData = MediaQuery.of(context);

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

        //* HOTEL ROOM
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                context.bloc<PageBloc>().add(GoToSearchRoomPage(0));
              },
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.7,
                  height: MediaQuery.of(context).size.height / 3.3,
                  // decoration: BoxDecoration(
                  //     border: Border.all(
                  //       // color: Colors.black,
                  //       width: 2.0,
                  //     ),
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.all(Radius.circular(20))),
                  // margin: EdgeInsets.fromLTRB(25, 10, 20, 12),
                  child: Center(
                    child: Text(
                      "Hotel Room",
                      style: blackTextFont.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.bloc<PageBloc>().add(GoToSearchRoomPage(1));
              },
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),

                              child: Container(
                  width: MediaQuery.of(context).size.width / 2.7,
                  height: MediaQuery.of(context).size.height / 3.3,
                  // decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: Colors.black,
                  //       width: 2.0,
                  //     ),
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.all(Radius.circular(20))),
                  // margin: EdgeInsets.fromLTRB(25, 10, 20, 12),
                  child: Center(
                    child: Text(
                      "Meeting Room",
                      style: blackTextFont.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
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
                width: MediaQuery.of(context).size.width / 2,
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
                          Icons.local_drink,
                          size: 16,
                        ),
                        'Mineral Water'),
                    ContentTile(
                        Icon(
                          Icons.hot_tub,
                          size: 16,
                        ),
                        'Clean Washroom'),
                    ContentTile(
                        Icon(
                          Icons.directions_walk,
                          size: 16,
                        ),
                        'Toiletries'),
                  ],
                ))),
        BlocBuilder<SearchRoomBloc, SearchRoomState>(builder: (context, state) {
          if (state is SearchRoomInitial) {
            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 0.5,
              backgroundColor: Colors.amber,
            ));
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 20, 5),
                child: Text(
                  "Recomended",
                  style: blackTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 20, 12),
                  height: MediaQuery.of(context).size.height / 5,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:3,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                                                      child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  width: MediaQuery.of(context).size.width / 1.3,
                                  height: MediaQuery.of(context).size.height / 6,
                                 
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width / 3,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: (state
                                                            .dataSearch
                                                            .room[index]
                                                            .picture ==
                                                        ""
                                                    ? AssetImage(
                                                        "assets/user_pic.png")
                                                    : NetworkImage(state
                                                        .dataSearch
                                                        .room[index]
                                                        .picture)),
                                                fit: BoxFit.cover)),
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              RatingStars(
                                                voteAverage: double.parse((state
                                                                .dataSearch
                                                                .room[index]
                                                                .rate ==
                                                            "null" ||
                                                        state
                                                                .dataSearch
                                                                .room[index]
                                                                .rate ==
                                                            null)
                                                    ? "5.0"
                                                    : state.dataSearch.room[index]
                                                        .rate),
                                                color: Colors.amber,
                                              ),
                                              Text(state.dataSearch.room[index]
                                                  .roomName),
                                              Text(state.dataSearch.room[index]
                                                  .roomName),
                                              Text(
                                                  "Rp. ${state.dataSearch.room[index].price.toString()} / Night"),
                                            ],
                                          )),
                                    ],
                                  )),
                            ),
                          ),
                        );
                      })),
            ],
          );
        }),
        ListTile(
            title: Text("Description"),
            subtitle: Container(
                // padding: EdgeInsets.all(2.0),
                width: MediaQuery.of(context).size.width / 1.2,
                // height: MediaQuery.of(context).size.height / 7,
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
