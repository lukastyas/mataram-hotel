part of 'pages.dart';

class SearchRoom extends StatelessWidget {
  const SearchRoom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.bloc<SearchRoomBloc>().add(LoadRoom());
    TextEditingController _controller = TextEditingController();
    TextEditingController _controllerChildren = TextEditingController();
    TextEditingController _controllerRooms = TextEditingController();
    DateTime selectedDate = DateTime.now();
    DateTime selectedDateto = DateTime.now();
    DateFormat dateFormat;
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToMainPage());

          return;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: accentColor1,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          padding: EdgeInsets.fromLTRB(
                              defaultMargin, 50, defaultMargin, 30),
                          child: BlocBuilder<UserBloc, UserState>(
                            builder: (_, userState) {
                              if (userState is UserLoaded) {
                                if (imageFileToUpluad != null) {
                                  uploadImage(imageFileToUpluad)
                                      .then((downloadURL) {
                                    imageFileToUpluad = null;
                                    context.bloc<UserBloc>().add(
                                        UpdateData(profileImage: downloadURL));
                                  });
                                }
                                print("INI");
                                print(userState.user.name);
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .bloc<PageBloc>()
                                            .add(GoToProfilePage());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Color(0xFF5F5588),
                                                width: 1)),
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
                                                      image: (userState.user
                                                                  .profilePicture ==
                                                              ""
                                                          ? AssetImage(
                                                              "assets/user_pic.png")
                                                          : NetworkImage(userState
                                                              .user
                                                              .profilePicture)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              2 * defaultMargin -
                                              78,
                                          child: Text(
                                            userState.user.name,
                                            style: whiteTextFont.copyWith(
                                                fontSize: 18),
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                        Text(
                                          userState.user.email,
                                          style: yellowNumberFont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
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
                        // Container(height: 100, width: 100, color: Colors.red),
                      ],
                    );
                  },
                ),
                BlocBuilder<SearchRoomBloc, SearchRoomState>(
                  builder: (context, state) {
                    dateFormat = new DateFormat("d MMMM yyyy");
                     _controller.text = "0"; // if (state is RoomLoaded) {
                     _controllerChildren.text = "0"; // if (state is RoomLoaded) {
                     _controllerRooms.text = "0"; // if (state is RoomLoaded) {
                    if (state is SearchRoomInitial) {
                      return Container();
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 5,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          margin: EdgeInsets.fromLTRB(25, 10, 20, 12),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.date_range),
                                    GestureDetector(
                                      onTap: () async {
                                        final DateTime picked =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2015, 8),
                                                lastDate: DateTime(2040, 1));

                                        if (picked != null &&
                                            picked != selectedDate) {
                                          state.dataSearch.selecetedDateFrom =
                                              picked;

                                          context
                                              .bloc<SearchRoomBloc>()
                                              .add(OnChangeDate());
                                        }
                                      },
                                      child: Text(
                                        state?.dataSearch?.selecetedDateFrom ==
                                                null
                                            ? "Check-In"
                                            : dateFormat.format(state
                                                .dataSearch.selecetedDateFrom),
                                        style: blackTextFont.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.date_range),
                                    GestureDetector(
                                      onTap: () async {
                                          final DateTime picked =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2015, 8),
                                                lastDate: DateTime(2040, 1));

                                        if (picked != null &&
                                            picked != selectedDate) {
                                          state.dataSearch.selecetedDateTo =
                                              picked;

                                          context
                                              .bloc<SearchRoomBloc>()
                                              .add(OnChangeDate());
                                        }
                                      },
                                      child: Text(
                                       state?.dataSearch?.selecetedDateTo ==
                                                null
                                            ? "Checkout"
                                            : dateFormat.format(state
                                                .dataSearch.selecetedDateTo),
                                        style: blackTextFont.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Adult(s)"),
                                    Container(
                                      width: 40.0,
                                      height: 30.0,
                                      foregroundDecoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: Colors.blueGrey,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(8.0),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              controller: _controller,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                decimal: false,
                                                signed: true,
                                              ),
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                WhitelistingTextInputFormatter
                                                    .digitsOnly
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 30.0,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  child: InkWell(
                                                    child: Icon(
                                                      Icons.arrow_drop_up,
                                                      size: 10.0,
                                                    ),
                                                    onTap: () {
                                                      int currentValue =
                                                          int.parse(
                                                              _controller.text);
                                                      currentValue++;
                                                      _controller.text =
                                                          (currentValue)
                                                              .toString(); //
                                                    },
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 10.0,
                                                  ),
                                                  onTap: () {
                                                    int currentValue =
                                                          int.parse(
                                                              _controller.text);
                                                      currentValue--;
                                                      _controller.text =
                                                          (currentValue)
                                                              .toString();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text("Children"),
                                    Container(
                                      width: 40.0,
                                      height: 30.0,
                                      foregroundDecoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: Colors.blueGrey,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(8.0),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              controller: _controllerChildren,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                decimal: false,
                                                signed: true,
                                              ),
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                WhitelistingTextInputFormatter
                                                    .digitsOnly
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 30.0,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  child: InkWell(
                                                    child: Icon(
                                                      Icons.arrow_drop_up,
                                                      size: 10.0,
                                                    ),
                                                    onTap: () {
                                                      int currentValue =
                                                          int.parse(
                                                              _controllerChildren.text);
                                                      currentValue++;
                                                      _controllerChildren.text =
                                                          (currentValue)
                                                              .toString(); //
                                                    },
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 10.0,
                                                  ),
                                                  onTap: () {
                                                int currentValue =
                                                          int.parse(
                                                              _controllerChildren.text);
                                                      currentValue--;
                                                      _controllerChildren.text =
                                                          (currentValue)
                                                              .toString(); 
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text("Rooms"),
                                    SizedBox(width: 5),
                                    Container(
                                      width: 40.0,
                                      height: 30.0,
                                      foregroundDecoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: Colors.blueGrey,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(8.0),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              controller: _controllerRooms,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                decimal: false,
                                                signed: true,
                                              ),
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                WhitelistingTextInputFormatter
                                                    .digitsOnly
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 30.0,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  child: InkWell(
                                                    child: Icon(
                                                      Icons.arrow_drop_up,
                                                      size: 10.0,
                                                    ),
                                                    onTap: () {
                                                      int currentValue =
                                                          int.parse(
                                                              _controllerRooms.text);
                                                      currentValue++;
                                                      _controllerRooms.text =
                                                          (currentValue)
                                                              .toString(); //
                                                    },
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 10.0,
                                                  ),
                                                  onTap: () {
                                                    int currentValue =
                                                          int.parse(
                                                              _controllerRooms.text);
                                                      currentValue--;
                                                      _controllerRooms.text =
                                                          (currentValue)
                                                              .toString(); //
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                itemCount: state.dataSearch.room.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      context.bloc<PageBloc>().add(
                                          GotoDetailRoom(
                                              state.dataSearch.room[index]));

                                      return;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 2.0,
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      RatingStars(
                                                        voteAverage: state
                                                            .dataSearch
                                                            .room[index]
                                                            .rate
                                                            .toDouble(),
                                                        color: Colors.amber,
                                                      ),
                                                      Text(state
                                                          .dataSearch
                                                          .room[index]
                                                          .roomName),
                                                      Text(state
                                                          .dataSearch
                                                          .room[index]
                                                          .roomName),
                                                      Text(
                                                          "Rp. ${state.dataSearch.room[index].price.toString()} / Night"),
                                                    ],
                                                  )),
                                            ],
                                          )),
                                    ),
                                  );
                                })),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 10, 20, 5),
                          child: Text(
                            "All Room",
                            style: blackTextFont.copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(25, 10, 20, 12),
                            height: MediaQuery.of(context).size.height / 2.3,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.dataSearch.room.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4.5,
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
                                                    top: 8.0,
                                                    left: 8.0,
                                                    right: 8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    RatingStars(
                                                      voteAverage: state
                                                          .dataSearch
                                                          .room[index]
                                                          .rate
                                                          .toDouble(),
                                                      color: Colors.amber,
                                                    ),
                                                    Text(state.dataSearch
                                                        .room[index].roomName),
                                                    Text(state.dataSearch
                                                        .room[index].roomName),
                                                    Text(
                                                        "Rp. ${state.dataSearch.room[index].price.toString()} / Night"),
                                                  ],
                                                )),
                                          ],
                                        )),
                                  );
                                })),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
