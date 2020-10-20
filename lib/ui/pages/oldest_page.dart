part of 'pages.dart';

class Oldest extends StatelessWidget {
  const Oldest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.bloc<PageBloc>().add(GotoNewestPage());
    DateFormat dateFormat;
    DateFormat dateFormatHour;
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        dateFormat = new DateFormat("d MMM yyyy");

        if (state is OnNewestPage) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.1,
            padding: EdgeInsets.only(top: 100),
            child: ListView.builder(
                itemCount: state.book.length,
                itemBuilder: (context, index) {
                  final difference = DateTime.parse(state.book[index].checkIn)
                      .difference(DateTime.now())
                      .inDays;

                  print("ini");
                  print(difference);

                  if (firebaseUser.uid == state.book[index].idUser &&
                      0 > difference) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetailUserPage(
                                        book: state.book[index],
                                      )));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              // margin: const EdgeInsets.all(18.0),

                              // height: MediaQuery.of(context).size.height / 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6.5,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: (state.book[index]
                                                          .thumbnail ==
                                                      ""
                                                  ? AssetImage(
                                                      "assets/user_pic.png")
                                                  : NetworkImage(state
                                                      .book[index].thumbnail)),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      // width: MediaQuery.of(context).size.width / 2,
                                      child: Text(state.book[index].roomName
                                          .toString()),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(dateFormat.format(DateTime.parse(
                                            state.book[index].checkIn))),
                                        Text(' - '),
                                        Text(dateFormat.format(DateTime.parse(
                                            state.book[index].checkOut))),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text("${state.book[index].room} Room"),
                                        Text(' - '),
                                        Text(
                                            "${state.book[index].totalNight} Nights"),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text("Status"),
                                        Text(' : '),
                                        Text(
                                            state.book[index].status
                                                        .toString() ==
                                                    "1"
                                                ? "Pending"
                                                : state.book[index].status
                                                            .toString() ==
                                                        "2"
                                                    ? "Success"
                                                    : "Canceled",
                                            style: TextStyle(
                                                color: state.book[index].status
                                                            .toString() ==
                                                        "1"
                                                    ? Colors.amber
                                                    : state.book[index].status
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
                        ));
                  }
                  return Center(child: Container());
                }),
          );
        }
        return Container();
      },
    );
  }
}
