part of 'pages.dart';

class ReviewPage extends StatefulWidget {
  final BookModels book;

  const ReviewPage({Key key, this.book}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final noController = TextEditingController();
     double rateResult;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: accentColor1,
          title: Text("Review"),
        ),
        body: BlocListener<SendEvidenceBloc, SendEvidenceState>(
          listener: (context, state) {
            print(state);
            if (state is OnSuccess) {
              // Flushbar(
              //   duration: Duration(milliseconds: 1500),
              //   flushbarPosition: FlushbarPosition.BOTTOM,
              //   backgroundColor: Colors.green,
              //   message: 'Success',
              // )..show(context);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  SizedBox(
                    height: 50.0,
                  ),
                  RatingBar(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      setState(() {
                        rateResult = rating;
                      });
                      print(rateResult);
                    },
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    child: TextField(
                        controller: noController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Describe Your Experience",
                          hintText: "Describe Your Experience",
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                    ),
                    child: MataramButton(
                      onPressed: () async {
                        print(rateResult);
                        context.bloc<SendEvidenceBloc>().add(SendReview(
                            rateResult, noController.text, widget.book.idRoom));
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
        ));
  }
}
