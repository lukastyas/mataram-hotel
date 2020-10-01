part of 'pages.dart';

class BookingDetail extends StatefulWidget {
  final BookModels book;
  final PageEvent pageEvent;

  const BookingDetail({Key key, this.book, this.pageEvent}) : super(key: key);

  @override
  _BookingDetailState createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    dateFormat = new DateFormat("d MMMM yyyy");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: accentColor1,
          title: Text("Book Detail"),
        ),
        body: BlocBuilder<SendEvidenceBloc, SendEvidenceState>(
          builder: (context, state) {
             if (state is SendEvidenceInitial) {
                Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 0.5,
                ));
              } else if (state is OnSuccess) {
                context.bloc<PageBloc>().add(widget.pageEvent);
                Flushbar(
                  duration: Duration(milliseconds: 1500),
                  flushbarPosition: FlushbarPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  message: "Success",
                )..show(context);
              }
              print("======state=====");
              print(state);
            return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        // height: MediaQuery.of(context).size.height / 3,
        
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
                        height: MediaQuery.of(context).size.height / 6.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: (widget.book.thumbnail == ""
                                    ? AssetImage("assets/user_pic.png")
                                    : NetworkImage(widget.book.thumbnail)),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        // width: MediaQuery.of(context).size.width / 2,
                        child: Text(widget.book.roomName.toString()),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        // width: MediaQuery.of(context).size.width / 2,
                        child: Text("ID User : ${widget.book.idUser.toString()}"),
                      ),
                      Row(
                        children: <Widget>[
                          Text(dateFormat
                              .format(DateTime.parse(widget.book.checkIn))),
                          Text(' - '),
                          Text(dateFormat
                              .format(DateTime.parse(widget.book.checkOut))),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("${widget.book.room} Room"),
                          Text(' - '),
                          Text("${widget.book.totalNight} Nights"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              widget.book.evidence.isEmpty
                  ? Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text("No Evidence"))
                  : Container(
                      margin: const EdgeInsets.all(18.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          color: Colors.white,
                          image: DecorationImage(
                              image: (widget.book.evidence == ""
                                  ? AssetImage("assets/user_pic.png")
                                  : NetworkImage(widget.book.evidence)),
                              fit: BoxFit.fill)),
                    ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: MataramButton(
                  onPressed: () async {
                    context.bloc<SendEvidenceBloc>().add(SendApproval(
                        widget.book.idOrder, widget.book.idUser, '2'));
                  },
                  title: Text(
                    "Approval",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: 'edit',
                ),
              )
            ],
          ),
        )       ;
          },
        ),
      ),
    );
  }
}
