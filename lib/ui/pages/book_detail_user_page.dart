part of 'pages.dart';

class BookDetailUserPage extends StatefulWidget {
  final BookModels book;
  const BookDetailUserPage({Key key, this.book}) : super(key: key);

  @override
  _BookDetailUserPageState createState() => _BookDetailUserPageState();
}

class _BookDetailUserPageState extends State<BookDetailUserPage> {
  DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    dateFormat = new DateFormat("d MMMM yyyy");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentColor1,
        title: Text("Ticket Detail"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(50.0),
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: (widget.book.thumbnail == ""
                            ? AssetImage("assets/user_pic.png")
                            : NetworkImage(widget.book.thumbnail)),
                        fit: BoxFit.contain)),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                // width: MediaQuery.of(context).size.width / 2,
                child: Text(widget.book.roomName.toString()),
              ),
              Row(
                children: <Widget>[
                  Text(dateFormat.format(DateTime.parse(widget.book.checkIn))),
                  Text(' - '),
                  Text(dateFormat.format(DateTime.parse(widget.book.checkOut))),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("${widget.book.room} Room"),
                  Text(' - '),
                  Text("${widget.book.totalNight} Nights"),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 16),
                child: generateDashedDivider(
                    MediaQuery.of(context).size.width - 5.6 * defaultMargin),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Room Name"),
                  Text(widget.book.roomName),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Paid"),
                  Text(widget.book.price.toString()),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 50,
                  left: 80,
                ),
                child: MataramButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewPage(
                                  book: widget.book,
                                )));
                  },
                  title: Text(
                    "Please Review Us",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: 'edit',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
