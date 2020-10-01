part of 'pages.dart';

class BookDetail extends StatelessWidget {
  final RoomModel room;
  final uid;

  const BookDetail(
    this.uid,
    this.room, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GotoDetailRoom(room));
        return;
      },
      child: BlocBuilder<SearchRoomBloc, SearchRoomState>(
        builder: (context, state) {
          dateFormat = new DateFormat("d MMMM yyyy");
          var price = room.price;
          final difference = state.dataSearch.selecetedDateTo
              .difference(state.dataSearch.selecetedDateFrom)
              .inDays;
          final total = price * difference;
          final totalRoom = (price * state.dataSearch.rooms) * difference;
          final wallet = totalRoom + total;
          print(" dir$difference");
          print(total);

          final formatCurrency =
              new NumberFormat.simpleCurrency(locale: 'id_ID');
          var uuid = Uuid();
          var v4crypto = uuid.v4(options: {'rng': UuidUtil.cryptoRNG});
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width: 100,
                          padding: const EdgeInsets.only(top: 50.0, bottom: 30),
                          child: Text(
                            "Checkout Room",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 5,
                            height: MediaQuery.of(context).size.height / 7,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: (room.picture == ""
                                        ? AssetImage("assets/user_pic.png")
                                        : NetworkImage(room.picture)),
                                    fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              children: <Widget>[
                                Text(room.roomName),
                                RatingStars(
                                  voteAverage: room.rate == null
                                      ? 1.0
                                      : double.parse(room.rate),
                                  color: Colors.amber,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20, bottom: 16, left: 20),
                        child: generateDashedDivider(
                            MediaQuery.of(context).size.width / 1.2),
                      ),
                      MataramTile(
                        title: Text('Order ID'),
                        subtitle: Text(
                          v4crypto,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      MataramTile(
                        title: Text('Check-In'),
                        subtitle: Text(dateFormat.format(
                          state.dataSearch.selecetedDateFrom,
                        )),
                      ),
                      MataramTile(
                          title: Text('CheckOut'),
                          subtitle: Text(dateFormat.format(
                            state.dataSearch.selecetedDateTo,
                          ))),
                      room.type == "2"
                          ? Container()
                          : MataramTile(
                              title: Text('Adult'),
                              subtitle:
                                  Text(state.dataSearch.adult.toString())),
                      room.type == "2"
                          ? Container()
                          : MataramTile(
                              title: Text('Children'),
                              subtitle:
                                  Text(state.dataSearch.children.toString())),
                      room.type == "2"
                          ? Container()
                          : MataramTile(
                              title: Text('Room'),
                              subtitle: Text(state.dataSearch.rooms.toString()),
                            ),
                      MataramTile(
                          title: Text('Price'),
                          subtitle: Text(
                              "${formatCurrency.format(price)} x ${state.dataSearch.rooms.toString()} Room(s)")),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20, bottom: 16, left: 20),
                        child: generateDashedDivider(
                            MediaQuery.of(context).size.width / 1.2),
                      ),
                      MataramTile(
                        title: Text('Total'),
                        subtitle: Text("${formatCurrency.format(totalRoom)}",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: EdgeInsets.all(70),
                        child: MataramButton(
                          onPressed: () {
                            context.bloc<PageBloc>().add(GotoTransferPage(
                                idOrder: v4crypto,
                                uid: uid,
                                totalNight: difference,
                                room: state.dataSearch.rooms,
                                back: false,
                                wallet: wallet,
                                selecetedDateFrom:
                                    state.dataSearch.selecetedDateFrom,
                                selecetedDateTo:
                                    state.dataSearch.selecetedDateTo,
                                roomModel: room));
                            return;
                          },
                          title: Text(
                            "Checkout  Now",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: 'edit',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
