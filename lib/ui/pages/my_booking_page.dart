part of 'pages.dart';

class MyBookingPage extends StatefulWidget {
  final List<BookModels> bookModels;
  final List<RoomModel> roomModels;
  final PageEvent pageEvent;
  final role;

  MyBookingPage(
    this.bookModels,
    this.pageEvent,
    this.role,
    this.roomModels,
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
    print("firebaseUser.uid");
    print(widget.bookModels[0].type);
    print(widget.roomModels[0].roomName);
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
                  // child: Icon(
                  //   Icons.arrow_back,
                  //   color: Colors.black,
                  // ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: widget.bookModels.length,
                  // ignore: missing_return
                  itemBuilder: (context, index) {
//* Halaman my booking diberi kondisi dimana user id harus sama dengan user id booking dan ini hanya untuk role costumer
//* Custommer role 0 dan admin role 1

                    if (firebaseUser.uid == widget.bookModels[index].idUser &&
                        widget.role == 0 &&
                        widget.bookModels[index].status.toString() == "1") {
                      return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => BookDetailUserPage(
                            //               book: widget.bookModels[index],
                            //             )));
                          },
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(18.0),

                                    // height: MediaQuery.of(context).size.height / 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                                                6.5,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: (widget
                                                                .bookModels[
                                                                    index]
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
                                          widget.bookModels[index].type == "0"
                                              ? Container()
                                              : Row(
                                                  children: <Widget>[
                                                    Text("Start Event"),
                                                    Text(' : '),
                                                    Text(widget
                                                        .bookModels[index]
                                                        .startEvent
                                                        .toString()),
                                                  ],
                                                ),
                                          widget.bookModels[index].type == "0"
                                              ? Text(
                                                  "Check Out : ${dateFormat.format(DateTime.parse(widget.bookModels[index].checkOut))}")
                                              : Text(
                                                  "End Event : ${widget.bookModels[index].checkOut}"),
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
                                              Text(
                                                  "Status"), //* Status Booking jika status adalah 1 maka booking masih dalam status Processing
                                              //* Jika 2 Sukses
                                              Text(' : '),
                                              Text(
                                                  widget.bookModels[index]
                                                              .status
                                                              .toString() ==
                                                          "1"
                                                      ? "Processing"
                                                      : widget.bookModels[index]
                                                                  .status
                                                                  .toString() ==
                                                              "2"
                                                          ? "Success"
                                                          : "Pending",
                                                  style: TextStyle(
                                                      color: widget
                                                                  .bookModels[
                                                                      index]
                                                                  .status
                                                                  .toString() ==
                                                              "1"
                                                          ? Colors.amber
                                                          : widget
                                                                      .bookModels[
                                                                          index]
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
                                  ))));
                    } else if (widget.role == 1) {
                      return GestureDetector(
                        onTap: () {
                          widget.role == 1
                              ? context.bloc<PageBloc>().add(GotoBookingDetail(
                                  widget.bookModels[index], widget.pageEvent))
                              // ignore: unnecessary_statements
                              : null;
                        },
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2.6,
                            margin: const EdgeInsets.all(18.0),

                            // height: MediaQuery.of(context).size.height / 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(dateFormat.format(DateTime.parse(
                                          widget.bookModels[index].checkIn))),
                                      Text(' - '),
                                      widget.bookModels[index].type == "0"
                                          ? Text(
                                              "${dateFormat.format(DateTime.parse(widget.bookModels[index].checkOut))}")
                                          : Text(
                                              "End Event : ${widget.bookModels[index].checkOut}"),
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
