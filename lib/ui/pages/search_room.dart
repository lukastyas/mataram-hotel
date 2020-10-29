part of 'pages.dart';

class SearchRoom extends StatelessWidget {
  final typeRoom;
  const SearchRoom({
    Key key,
    this.typeRoom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.bloc<SearchRoomBloc>().add(LoadRoom(typeRoom: typeRoom));
    TextEditingController _controller = TextEditingController();
    TextEditingController _controllerChildren = TextEditingController();
    TextEditingController _controllerRooms = TextEditingController();
    DateTime selectedDate = DateTime.now();
    DateFormat dateFormat;
    DateFormat dateFormatHour;

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
                    dateFormatHour = new DateFormat("hh:mm");
                    _controller.text = "0"; // if (state is RoomLoaded) {
                    _controllerChildren.text =
                        "0"; // if (state is RoomLoaded) {
                    _controllerRooms.text = "0"; // if (state is RoomLoaded) {
                    if (state is SearchRoomInitial) {
                      return Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 0.5,
                        backgroundColor: Colors.amber,
                      ));
                    }
                    if (typeRoom == 0) {
                      //* Kondisi typeRoom Jika 0 bearti memilih hotel room jika 1 adalah meeeting room
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            margin: EdgeInsets.fromLTRB(25, 10, 20, 12),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, bottom: 20.0),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.date_range),
                                        GestureDetector(
                                          onTap: () async {
                                            final DateTime picked =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now()
                                                        .add(Duration(days: 1)),
                                                    firstDate: DateTime.now(),
                                                    lastDate:
                                                        DateTime(2040, 1));

                                            if (picked != null &&
                                                picked != selectedDate) {
                                              state.dataSearch
                                                  .selecetedDateFrom = picked;

                                              context
                                                  .bloc<SearchRoomBloc>()
                                                  .add(OnChangeDate());
                                            }
                                          },
                                          child: Text(
                                            state?.dataSearch
                                                        ?.selecetedDateFrom ==
                                                    null
                                                ? "Check-In"
                                                : dateFormat.format(state
                                                    .dataSearch
                                                    .selecetedDateFrom),
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
                                                    initialDate: state
                                                        .dataSearch
                                                        .selecetedDateFrom
                                                        .add(Duration(days: 1)),
                                                    firstDate: DateTime.now(),
                                                    lastDate: state.dataSearch
                                                        .selecetedDateFrom
                                                        .add(Duration(
                                                            days: 30)));

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
                                            state?.dataSearch
                                                        ?.selecetedDateTo ==
                                                    null
                                                ? "Checkout"
                                                : dateFormat.format(state
                                                    .dataSearch
                                                    .selecetedDateTo),
                                            style: blackTextFont.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Adult(s)"),
                                          Container(
                                            width: 40.0,
                                            // height: 0.0,
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
                                                  child: Center(
                                                    child: Text(state
                                                        .dataSearch.adult
                                                        .toString()),
                                                  ),
                                                ),
                                                Container(
                                                  // height: 30.0,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                        ),
                                                        child: InkWell(
                                                          child: Icon(
                                                            Icons.arrow_drop_up,
                                                            size: 20.0,
                                                          ),
                                                          onTap: () {
                                                            int currentValue =
                                                                state.dataSearch
                                                                    .adult;
                                                            currentValue++;
                                                            state.dataSearch
                                                                    .adult =
                                                                (currentValue);

                                                            context
                                                                .bloc<
                                                                    SearchRoomBloc>()
                                                                .add(
                                                                    OnChangeDate());
                                                          },
                                                        ),
                                                      ),
                                                      InkWell(
                                                        child: Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 20.0,
                                                        ),
                                                        onTap: () {
                                                          int currentValue =
                                                              state.dataSearch
                                                                  .adult;
                                                          currentValue--;
                                                          state.dataSearch
                                                                  .adult =
                                                              (currentValue);
                                                          if (state.dataSearch
                                                                  .adult <=
                                                              0) {
                                                            state.dataSearch
                                                                .adult = 0;
                                                          }

                                                          context
                                                              .bloc<
                                                                  SearchRoomBloc>()
                                                              .add(
                                                                  OnChangeDate());
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
                                            // height: 30.0,
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
                                                  child: Center(
                                                    child: Text(state
                                                        .dataSearch.children
                                                        .toString()),
                                                  ),
                                                ),
                                                Container(
                                                  // height: 30.0,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                        ),
                                                        child: InkWell(
                                                          child: Icon(
                                                            Icons.arrow_drop_up,
                                                            size: 20.0,
                                                          ),
                                                          onTap: () {
                                                            int currentValue =
                                                                state.dataSearch
                                                                    .children;
                                                            currentValue++;
                                                            state.dataSearch
                                                                    .children =
                                                                (currentValue);

                                                            context
                                                                .bloc<
                                                                    SearchRoomBloc>()
                                                                .add(
                                                                    OnChangeDate());
                                                          },
                                                        ),
                                                      ),
                                                      InkWell(
                                                        child: Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 20.0,
                                                        ),
                                                        onTap: () {
                                                          int currentValue =
                                                              state.dataSearch
                                                                  .children;
                                                          currentValue--;
                                                          state.dataSearch
                                                                  .children =
                                                              (currentValue);
                                                          if (state.dataSearch
                                                                  .children <=
                                                              0) {
                                                            state.dataSearch
                                                                .children = 0;
                                                          }

                                                          context
                                                              .bloc<
                                                                  SearchRoomBloc>()
                                                              .add(
                                                                  OnChangeDate());
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
                                            // height: 30.0,
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
                                                  child: Center(
                                                    child: Text(state
                                                        .dataSearch.rooms
                                                        .toString()),
                                                  ),
                                                ),
                                                Container(
                                                  // height: 30.0,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                        ),
                                                        child: InkWell(
                                                          child: Icon(
                                                            Icons.arrow_drop_up,
                                                            size: 20.0,
                                                          ),
                                                          onTap: () {
                                                            int currentValue =
                                                                state.dataSearch
                                                                    .rooms;
                                                            currentValue++;
                                                            state.dataSearch
                                                                    .rooms =
                                                                (currentValue);

                                                            context
                                                                .bloc<
                                                                    SearchRoomBloc>()
                                                                .add(
                                                                    OnChangeDate());
                                                          },
                                                        ),
                                                      ),
                                                      InkWell(
                                                        child: Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 20.0,
                                                        ),
                                                        onTap: () {
                                                          int currentValue =
                                                              state.dataSearch
                                                                  .rooms;
                                                          currentValue--;
                                                          state.dataSearch
                                                                  .rooms =
                                                              (currentValue);
                                                          if (state.dataSearch
                                                                  .rooms <=
                                                              0) {
                                                            state.dataSearch
                                                                .rooms = 0;
                                                          }

                                                          context
                                                              .bloc<
                                                                  SearchRoomBloc>()
                                                              .add(
                                                                  OnChangeDate());
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
                                    ),
                                    Text(
                                        "* Your Children age Min 12 years old"),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                            height: MediaQuery.of(context).size.height / 3,
                            child: Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 12),
                                child: GridView.builder(
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: .7,
                                            crossAxisCount: 2),
                                    // scrollDirection: Axis.horizontal,
                                    itemCount: state.dataSearch.room.length,
                                    itemBuilder: (context, index) {
                                      return state.dataSearch.room[index]
                                                  .noFRoom <=
                                              0
                                          ? Container()
                                          : GestureDetector(
                                              onTap: () {
                                                //* Validasi apabila ingin melanjutkan ke halaman booking

                                                if (state.dataSearch
                                                        .selecetedDateFrom ==
                                                    null) {
                                                  Flushbar(
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    flushbarPosition:
                                                        FlushbarPosition.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                    message:
                                                        "Please Insert your Chekck-in",
                                                  )..show(context);
                                                } else if (state.dataSearch
                                                        .selecetedDateTo ==
                                                    null) {
                                                  Flushbar(
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    flushbarPosition:
                                                        FlushbarPosition.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                    message:
                                                        "Please Insert your Chekck-out",
                                                  )..show(context);
                                                } else if (state
                                                        .dataSearch
                                                        .selecetedDateFrom
                                                        .day ==
                                                    DateTime.now().day) {
                                                  Flushbar(
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    flushbarPosition:
                                                        FlushbarPosition.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                    message:
                                                        "Please Check your Chekck-in, start event max < 1 days",
                                                  )..show(context);
                                                } else {
                                                  context.bloc<PageBloc>().add(
                                                      GotoDetailRoom(state
                                                          .dataSearch
                                                          .room[index]));

                                                  return;
                                                }
                                              },
                                              child: Card(
                                                elevation: 1,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                6,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: (state.dataSearch.room[index].picture ==
                                                                            ""
                                                                        ? AssetImage(
                                                                            "assets/user_pic.png")
                                                                        : NetworkImage(state
                                                                            .dataSearch
                                                                            .room[
                                                                                index]
                                                                            .picture)),
                                                                    fit: BoxFit
                                                                        .cover)),
                                                          ),
                                                          Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 8.0,
                                                                      right:
                                                                          8.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  RatingStars(
                                                                    voteAverage: double.parse((state.dataSearch.room[index].rate ==
                                                                                "null" ||
                                                                            state.dataSearch.room[index].rate ==
                                                                                null)
                                                                        ? "7.0"
                                                                        : state
                                                                            .dataSearch
                                                                            .room[index]
                                                                            .rate),
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                  Text(state
                                                                      .dataSearch
                                                                      .room[
                                                                          index]
                                                                      .roomName),
                                                                  Text(
                                                                      "No of room : ${state.dataSearch.room[index].noFRoom}"),
                                                                  Text(
                                                                      "Rp. ${state.dataSearch.room[index].price.toString()} / Night"),
                                                                ],
                                                              )),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            );
                                    })),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            margin: EdgeInsets.fromLTRB(25, 10, 20, 12),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, bottom: 20.0),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.date_range),
                                        GestureDetector(
                                          onTap: () async {
                                            final DateTime picked =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now()
                                                        .add(Duration(days: 1)),
                                                    firstDate: DateTime.now(),
                                                    lastDate:
                                                        DateTime(2040, 1));

                                            if (picked != null &&
                                                picked != selectedDate) {
                                              state.dataSearch
                                                  .selecetedDateFrom = picked;

                                              context
                                                  .bloc<SearchRoomBloc>()
                                                  .add(OnChangeDate());
                                            }
                                          },
                                          child: Text(
                                            state?.dataSearch
                                                        ?.selecetedDateFrom ==
                                                    null
                                                ? "Event Date"
                                                : dateFormat.format(state
                                                    .dataSearch
                                                    .selecetedDateFrom),
                                            style: blackTextFont.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Start Event : ",
                                          style: blackTextFont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            var picked =
                                                await DatePicker.showTimePicker(
                                                    context,
                                                    showTitleActions: true,
                                                    onChanged: (date) {
                                              print(
                                                  'change $date in time zone ' +
                                                      date.timeZoneOffset
                                                          .inHours
                                                          .toString());
                                            }, onConfirm: (date) {
                                              print('confirm $date');
                                            }, currentTime: DateTime.now());

                                            print("ini");
                                            print(picked);
                                            state.dataSearch.timeOfDay = picked;

                                            context
                                                .bloc<SearchRoomBloc>()
                                                .add(OnChangeDate());
                                          },
                                          child: Text(
                                            state?.dataSearch?.timeOfDay == null
                                                ? "Choose your start event"
                                                : dateFormatHour.format(
                                                    state.dataSearch.timeOfDay),
                                            style: blackTextFont.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 10, 20, 5),
                            child: Text(
                              "All Room",
                              style: blackTextFont.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),SizedBox(height: 5),
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 12),
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: GridView.builder(
                                  gridDelegate:
                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: .65,
                                          crossAxisCount: 2),
                                  // scrollDirection: Axis.horizontal,
                                  itemCount: state.dataSearch.room.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        //* Validasi apabila ingin melanjutkan ke halaman booking
print(state.dataSearch.book.length);
                                        if (state
                                                .dataSearch.selecetedDateFrom ==
                                            null) {
                                          Flushbar(
                                            duration:
                                                Duration(milliseconds: 1500),
                                            flushbarPosition:
                                                FlushbarPosition.BOTTOM,
                                            backgroundColor: Colors.red,
                                            message:
                                                "Please Insert your Event Date",
                                          )..show(context);
                                        } else if (state.dataSearch.timeOfDay ==
                                            null) {
                                          Flushbar(
                                            duration:
                                                Duration(milliseconds: 1500),
                                            flushbarPosition:
                                                FlushbarPosition.BOTTOM,
                                            backgroundColor: Colors.red,
                                            message:
                                                "Please Insert your Start Event",
                                          )..show(context);
                                        } else if (state.dataSearch
                                                .selecetedDateFrom.day ==
                                            DateTime.now().day) {
                                          Flushbar(
                                            duration:
                                                Duration(milliseconds: 1500),
                                            flushbarPosition:
                                                FlushbarPosition.BOTTOM,
                                            backgroundColor: Colors.red,
                                            message:
                                                "Please Check your Start Event, start event max < 1 days",
                                          )..show(context);
                                        } else if (state
                                                .dataSearch.book.length ==
                                            0) {
                                          context.bloc<PageBloc>().add(
                                              GotoDetailRoom(state
                                                  .dataSearch.room[index]));

                                          return;
                                        } else if (state
                                                .dataSearch.book.length !=
                                            0) {
                                          if (state.dataSearch.type == "1") {
                                            if (state
                                                    .dataSearch.statusCheckin !=
                                                "2") {
                                              Flushbar(
                                                duration: Duration(
                                                    milliseconds: 1500),
                                                flushbarPosition:
                                                    FlushbarPosition.BOTTOM,
                                                backgroundColor: Colors.red,
                                                message:
                                                    "Meeting Room Has Been booking",
                                              )..show(context);
                                            } else {
                                              context.bloc<PageBloc>().add(
                                                  GotoDetailRoom(state
                                                      .dataSearch.room[index]));

                                              return;
                                            }
                                          }else {
                                              context.bloc<PageBloc>().add(
                                                  GotoDetailRoom(state
                                                      .dataSearch.room[index]));

                                              return;
                                            }
                                        } else if(state.dataSearch.book.length == 0){
 context.bloc<PageBloc>().add(
                                                  GotoDetailRoom(state
                                                      .dataSearch.room[index]));
                                                }
                                      },
                                      child: Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            4.5,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: (state
                                                                        .dataSearch
                                                                        .room[
                                                                            index]
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
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          state
                                                                      .dataSearch
                                                                      .room[
                                                                          index]
                                                                      .rate ==
                                                                  null
                                                              ? Container()
                                                              : RatingStars(
                                                                  voteAverage: double.parse(state
                                                                              .dataSearch
                                                                              .room[
                                                                                  index]
                                                                              .rate ==
                                                                          "null"
                                                                      ? "7.0"
                                                                      : state
                                                                          .dataSearch
                                                                          .room[
                                                                              index]
                                                                          .rate),
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                          Text(state
                                                              .dataSearch
                                                              .room[index]
                                                              .roomName),
                                                          Text(
                                                              "Rp. ${state.dataSearch.room[index].price.toString()} / Pax"),
                                                          Text(
                                                              "Capacity : Min ${state.dataSearch.room[index].capacity}"),
                                                          Text(
                                                              "Duration : ${state.dataSearch.room[index].duration} Hours"),
                                                        ],
                                                      )),SizedBox(height: 300,)
                                                ],
                                              )),
                                        ),
                                      ),
                                    );
                                  })),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),);
  }
}
