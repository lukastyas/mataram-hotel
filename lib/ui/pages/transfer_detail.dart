part of 'pages.dart';

class TransferPage extends StatelessWidget {
  final wallet;
    final RoomModel room;

  const TransferPage({Key key, this.wallet, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print(room.price);
    print(room.data);
    return WillPopScope(onWillPop: () async {
      context.bloc<PageBloc>().add(GotoBookDetail(room));
      return;
    },
          child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Amount To be Paid",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Rp. 1212"),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            color: Colors.red,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Bank",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text("1020.1201.01221",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Please complete payment within 60 min"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 200),
                child: MataramButton(
                  onPressed: () {
                    context.bloc<PageBloc>().add(GotoSendEvidence(  room));
                    return;
                  },
                  title: Text(
                    "Send  Evidence",
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
