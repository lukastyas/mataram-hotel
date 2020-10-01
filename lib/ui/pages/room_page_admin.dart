part of 'pages.dart';

class RoomPageAdmin extends StatelessWidget {
  const RoomPageAdmin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.bloc<SearchRoomBloc>().add(LoadRoom(admin: true));

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70.0),
        child: FloatingActionButton(
          onPressed: () {
            print("aiiai");
            context.bloc<PageBloc>().add(GotoCreateRoom());
            return;
          },
          backgroundColor: mainColor,
          child: Icon(Icons.add),
        ),
      ),
      body: ListView(
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
                              border: Border.all(
                                  color: Color(0xFF5F5588), width: 1)),
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
          BlocBuilder<SearchRoomBloc, SearchRoomState>(
              builder: (context, state) {
            if (state is SearchRoomInitial) {
              return Container();
            }
            if (state is RoomLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(25, 10, 20, 12),
                      height: MediaQuery.of(context).size.height/1.5,
                      child: GridView.builder(
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 1.2),
                          ),
                          itemCount: state.dataSearch.room.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  width: MediaQuery.of(context).size.width / 2,
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6.5,
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
                                              top: 8.0, left: 8.0, right: 8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                            state. dataSearch.room[index].rate == null ? Container(): RatingStars(
                                                starSize: 12.0,
                                                voteAverage: double.parse( state
                                                    .dataSearch.room[index].rate),
                                                color: Colors.amber,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                    state.dataSearch.room[index]
                                                                .type ==
                                                            "1"
                                                        ? "Room Name"
                                                        : "Meeting Room Name",
                                                    style: TextStyle(
                                                        fontSize: 12.0)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                    state.dataSearch.room[index]
                                                        .roomName,
                                                    style: TextStyle(
                                                        fontSize: 12.0)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: state
                                                            .dataSearch
                                                            .room[index].type =="1" ? Text(
                                                    "Rp. ${state.dataSearch.room[index].price.toString()} / Pax") :Text(
                                                    "Rp. ${state.dataSearch.room[index].price.toString()} / Night"),
                                              ),
                                            ],
                                          )),
                                    ],
                                  )),
                            );
                          })),
                ],
              );
            }
            return Container();
          })
        ],
      ),
    );
  }
}
