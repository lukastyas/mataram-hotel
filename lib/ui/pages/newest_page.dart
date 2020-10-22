part of 'pages.dart';

class Newest extends StatelessWidget {
  const Newest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.bloc<PageBloc>().add(GotoNewestPage());
    DateFormat dateFormat;
    DateFormat dateFormatHour;
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        dateFormat = new DateFormat("d MMM yyyy");
        dateFormatHour = new DateFormat("hh:mm");

        if (state is OnNewestPage) {
          // final difference = DateTime.now()
          //     .difference(DateTime.parse(state?.book[0]?.checkOut))
          //     .inDays;
          // print("difference");
          // print(difference);
          // print(DateTime.parse(state.book[0].checkOut));
          // var a;
          // List<DateTime> b = [];
          // for (int x = 0; x <= difference; x++) {
          //   a = DateTime.parse(state.book[0].checkOut).add(Duration(days: x));
          //   b.add(
          //       DateTime.parse(state.book[0].checkOut).add(Duration(days: x)));
          // }
          // b.map((e) {
          //   print("1111");
          //   print(dateFormat.format(e));
          //   print(dateFormat.format(DateTime.now()));
          //   if (dateFormat.format(e) == dateFormat.format(DateTime.now())) {
          //     print("e");
          //     print(e);
          //   }
          // }).toList();
          return Container(
            height: MediaQuery.of(context).size.height / 1.1,
            padding: EdgeInsets.only(top: 100),
            child: ListView.builder(
                itemCount: state.book.length,
                itemBuilder: (context, index) {
                  // final difference = DateTime.now()
                  //     .difference(DateTime.parse(state.book[index].checkIn))
                  //     .inDays;
                
                   final before = DateTime.now().isBefore(DateTime.parse(state.book[index].checkIn));

                      print("before");
                      print(before);
                  if (firebaseUser.uid == state.book[index].idUser && 
                      state.book[index].status.toString() == "2" && before == true ) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetailUserPage(
                                        book: state.book[index],
                                      )));
                        },
                        child: 
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child:
                        Card(
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
                                    height: MediaQuery.of(context).size.height /
                                        6.5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                (state.book[index].thumbnail ==
                                                        ""
                                                    ? AssetImage(
                                                        "assets/user_pic.png")
                                                    : NetworkImage(state
                                                        .book[index]
                                                        .thumbnail)),
                                            fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    // width: MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                        state.book[index].roomName.toString()),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(state.book[index].type == "0"
                                          ? "Duration :"
                                          : "Event Date : "),
                                      Text(dateFormat.format(DateTime.parse(
                                          state.book[index].checkIn))),
                                      state.book[index].type == "1"
                                          ? Container()
                                          : Text(' - '),
                                      state.book[index].type == "1"
                                          ? Container()
                                          : Text(dateFormat.format(
                                              DateTime.parse(
                                                  state.book[index].checkOut))),
                                    ],
                                  ),
                                  state.book[index].type == "0"
                                      ? Container()
                                      : Row(
                                          children: <Widget>[
                                            Text("Start Event"),
                                            Text(' : '),
                                            Text(state.book[index].startEvent
                                                .toString()),
                                          ],
                                        ),
                                  state.book[index].type == "0"
                                      ? Container()
                                      : Row(
                                          children: <Widget>[
                                            Text("End Event"),
                                            Text(' : '),
                                            Text(state.book[index].checkOut
                                                .toString()),
                                          ],
                                        ),
                                  Text(
                                      "Check In : ${state.book[index].statuscheckIn == "1" || state.book[index].statuscheckIn == "2" ? dateFormatHour.format(DateTime.parse(state.book[index].checkIn)) : "-"}"),
                                  Text(
                                      "Check Out : ${state.book[index].statuscheckIn == "2" ? dateFormatHour.format(DateTime.parse(state.book[index].checkOut)) : "-"}"),
                                  state.book[index].type == "1"
                                      ? Container()
                                      : Row(
                                          children: <Widget>[
                                            Text(
                                                "${state.book[index].room} Room"),
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
                                          state.book[index].status.toString() ==
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
                        )));
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
