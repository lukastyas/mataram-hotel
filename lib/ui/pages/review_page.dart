part of 'pages.dart';

class ReviewPage extends StatelessWidget {
  final BookModels book;

  const ReviewPage({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: (book.thumbnail == ""
                          ? AssetImage("assets/user_pic.png")
                          : NetworkImage(book.thumbnail)),
                      fit: BoxFit.contain)),
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
   },
)
          ],
        ),
      ),
    );
  }
}
