part of 'pages.dart';

class MyBookingPage extends StatefulWidget {
  final List<BookModels> bookModels;
  final PageEvent pageEvent;
  final role;

  MyBookingPage(
    this.bookModels,
    this.pageEvent,
    this.role,
  );

  @override
  _MyBookingPageState createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  DateFormat dateFormat;
  String idOrderRoom;
  List<RoomModel> room = [];
  final dm = Barcode.qrCode();

  @override
  void initState() {
    super.initState();
    dateFormat = new DateFormat("d MMMM yyyy");
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);

        return;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: accentColor1,
          title: Text("Book"),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: defaultMargin),
                child: GestureDetector(
                  onTap: () {
                    context.bloc<PageBloc>().add(widget.pageEvent);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: widget.bookModels.length,
                  itemBuilder: (context, index) {
                    print(firebaseUser.uid);
                    print(widget.bookModels[index].idUser);
                    if (firebaseUser.uid == widget.bookModels[index].idUser &&
                        widget.role == 0 &&
                        widget.bookModels[index].status.toString() == "2") {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookDetailUserPage(
                                          book: widget.bookModels[index],
                                        )));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(18.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              color: Colors.white,
                            ),
                            // height: MediaQuery.of(context).size.height / 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height /
                                        6.5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: (widget.bookModels[index]
                                                        .thumbnail ==
                                                    ""
                                                ? AssetImage(
                                                    "assets/user_pic.png")
                                                : NetworkImage(widget
                                                    .bookModels[index]
                                                    .thumbnail)),
                                            fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    // width: MediaQuery.of(context).size.width / 2,
                                    child: Text(widget
                                        .bookModels[index].roomName
                                        .toString()),
                                  ),  
                                  Text(
                                      "Check In : ${dateFormat.format(DateTime.parse(widget.bookModels[index].checkIn))}"),
                                  Text(
                                      "Check Out : ${dateFormat.format(DateTime.parse(widget.bookModels[index].checkOut))}"),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                          "${widget.bookModels[index].room} Room"),
                                      Text(' - '),
                                      Text(
                                          "${widget.bookModels[index].totalNight} Nights"),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text("Status"),
                                      Text(' : '),
                                      Text(
                                          widget.bookModels[index].status
                                                      .toString() ==
                                                  "1"
                                              ? "Pending"
                                              : widget.bookModels[index].status
                                                          .toString() ==
                                                      "2"
                                                  ? "Success"
                                                  : "Pending",
                                          style: TextStyle(
                                              color: widget.bookModels[index]
                                                          .status
                                                          .toString() ==
                                                      "1"
                                                  ? Colors.amber
                                                  : widget.bookModels[index]
                                                              .status
                                                              .toString() ==
                                                          "2"
                                                      ? Colors.green
                                                      : Colors.red)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                    } else if (widget.role == 1) {
                      return GestureDetector(
                        onTap: () {
                          widget.role == 1
                              ? context.bloc<PageBloc>().add(GotoBookingDetail(
                                  widget.bookModels[index], widget.pageEvent))
                              // ignore: unnecessary_statements
                              : null;
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2.6,
                          margin: const EdgeInsets.all(18.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            color: Colors.white,
                          ),
                          // height: MediaQuery.of(context).size.height / 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: (widget.bookModels[index]
                                                      .thumbnail ==
                                                  ""
                                              ? AssetImage(
                                                  "assets/user_pic.png")
                                              : NetworkImage(widget
                                                  .bookModels[index]
                                                  .thumbnail)),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  // padding: EdgeInsets.all(8.0),
                                  // width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                      "Room Name : ${widget.bookModels[index].roomName.toString()}"),
                                ),
                                Container(
                                  // padding: EdgeInsets.all(8.0),
                                  // width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "ID User : ${widget.bookModels[index].idUser.toString()}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(dateFormat.format(DateTime.parse(
                                        widget.bookModels[index].checkIn))),
                                    Text(' - '),
                                    Text(dateFormat.format(DateTime.parse(
                                        widget.bookModels[index].checkOut))),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                        "${widget.bookModels[index].room} Room"),
                                    Text(' - '),
                                    Text(
                                        "${widget.bookModels[index].totalNight} Nights"),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text("Status"),
                                    Text(' : '),
                                    Text(
                                        widget.bookModels[index].status
                                                    .toString() ==
                                                "1"
                                            ? "Pending"
                                            : widget.bookModels[index].status
                                                        .toString() ==
                                                    "2"
                                                ? "Success"
                                                : "Pending",
                                        style: TextStyle(
                                            color: widget.bookModels[index]
                                                        .status
                                                        .toString() ==
                                                    "1"
                                                ? Colors.amber
                                                : widget.bookModels[index]
                                                            .status
                                                            .toString() ==
                                                        "2"
                                                    ? Colors.green
                                                    : Colors.red)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
