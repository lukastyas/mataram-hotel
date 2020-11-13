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
//  WidgetsBinding.instance.addPostFrameCallback((_) async {
//    if (widget.book.statuscheckIn == "2") {
//       await showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => new AlertDialog(
//               title: new Text("Please Rate Us"),
//               content: ReviewPage(
//                         book: widget.book,
//                       ),
             
//             ),
//       );
//    }
//     });
 
  }

  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: accentColor1,
          title: Text("Ticket Detail"),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.all(20.0),
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
                    Text(
                        dateFormat.format(DateTime.parse(widget.book.checkIn))),
                    Text(' - '),
                    widget.book.type == "1"
                                  ? Text(widget.book.checkOut.toString())
                                  : Text(dateFormat.format(
                                      DateTime.parse(widget.book.checkOut)))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("${widget.book.room} Room"),
                    widget.book.type == "1" ?Container():  Text(' - '),
                widget.book.type == "1" ?Container():  Text("${widget.book.totalNight} Nights"),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 16),
                  child: generateDashedDivider(
                      MediaQuery.of(context).size.width - 5.6 * defaultMargin),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Room Name"),
                          Text(widget.book.roomName),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Paid"),
                          Text(widget.book.price.toString()),
                        ],
                      ),
                    ),
                    Expanded(
                      child: QrImage(
                        version: 6,
                        foregroundColor: Colors.black,
                        errorCorrectionLevel: QrErrorCorrectLevel.M,
                        padding: EdgeInsets.all(0),
                        size: 100,
                        data: widget.book.idOrder,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 50,
                    left: 80,
                  ),
                  // child: MataramButton(
                  //   onPressed: () async {},
                  //   title: Text(
                  //     "Please Review Us",
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  //   color: 'edit',
                  // ),
                )
              ],
            ),
          ),
        ),
      );
  }
}
